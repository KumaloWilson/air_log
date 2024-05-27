import 'package:air_log/api_services/userprofile_services/userprofile_services.dart';
import 'package:air_log/utils/asset_utils/network_image_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../../models/userprofile.dart';
import '../../../../constant/colors.dart';
import '../../../widgets/custom_text_field.dart';

class TotalEmployees extends StatefulWidget {
  const TotalEmployees({super.key});

  @override
  State<TotalEmployees> createState() => _TotalEmployeesState();
}

class _TotalEmployeesState extends State<TotalEmployees> {
  late Future<List<UserProfile>> _usersFuture;

  String _searchQuery = '';

  void _searchUsers(String? query) {
    setState(() {
      _searchQuery = query!;
    });
  }

  Future<void> _toggleUserStatus(UserProfile user) async {
    await UserProfileServices.updateUserStatus(user.userId, !user.isAccountActive);
    setState(() {
      _usersFuture = UserProfileServices.fetchUsers();
    });
  }

  Future<void> _deleteUser(UserProfile user) async {
    await UserProfileServices.deleteUser(user.userId);
    setState(() {
      _usersFuture = UserProfileServices.fetchUsers();
    });
  }


  @override
  void initState() {
    super.initState();
    _usersFuture = UserProfileServices.fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
        title: const Text(
          'All Crew Members',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 16),
        ),
        centerTitle: true,
        backgroundColor: Pallete.primaryColor,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Container(
            decoration: const BoxDecoration(
              color: Pallete.primaryColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            color: Pallete.primaryColor.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black38,
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: Offset(-1, -1),
                              ),
                              BoxShadow(
                                color: Colors.white24,
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: Offset(1, 1),
                              ),
                            ]),
                        child: CustomTextField(
                          labelText: 'Search name',
                          labelStyle: TextStyle(
                              color: Pallete.primaryColor.withOpacity(0.5)),
                          defaultBoarderColor: Pallete.primaryColor,
                          focusedBoarderColor: Colors.transparent,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Pallete.primaryColor.withOpacity(0.5),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          onChanged: _searchUsers,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: DefaultTabController(
        length: 3,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Column(
            children: <Widget>[
              const TabBar(
                unselectedLabelColor: Colors.grey,
                labelColor: Pallete.primaryColor,
                labelStyle: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 12),
                unselectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.normal, fontSize: 12),
                tabs: [
                  Tab(
                    text: 'All',
                  ),
                  Tab(
                    text: 'Active',
                  ),
                  Tab(
                    text: 'DeActive',
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _buildUserList(_usersFuture),
                    _buildUserList(_usersFuture, active: true),
                    _buildUserList(_usersFuture, active: false),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserList(Future<List<UserProfile>> usersFuture, {bool? active}) {
    return FutureBuilder<List<UserProfile>>(
      future: usersFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: Pallete.primaryColor,));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No users found'));
        } else {
          List<UserProfile> users = snapshot.data!;
          if (active != null) {
            users = users.where((user) => user.isAccountActive == active).toList();
          }
          if (_searchQuery.isNotEmpty) {
            users = users.where((user) => user.fullName.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
          }
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              UserProfile user = users[index];
              return Slidable(
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                        icon: !user.isAccountActive ? Icons.check_circle : Icons.cancel,
                        padding: const EdgeInsets.all(2),
                        backgroundColor: !user.isAccountActive ?  Pallete.primaryColor : Colors.redAccent,
                        label: !user.isAccountActive ?'Activate' : 'DeActivate',
                        onPressed: (context) async {
                          await _toggleUserStatus(user);
                        }
                    ),
                    SlidableAction(
                        icon: Icons.delete_forever,
                        backgroundColor: Colors.redAccent,
                        label: 'Delete',
                        padding: const EdgeInsets.all(2),
                        onPressed: (context) async {
                          await _deleteUser(user);
                        }
                    ),
                  ],
                ),

                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      user.displayImage!.isNotEmpty
                          ? user.displayImage!
                          : MyNetworkImageAssets.defaultProfilePic
                    ),
                  ),
                  title: Text(
                      user.fullName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                      user.staffNumber,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12
                    ),
                  ),
                  trailing: Icon(
                    user.isAccountActive ? Icons.check_circle : Icons.cancel,
                    color: user.isAccountActive ? Colors.green : Colors.red,
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
