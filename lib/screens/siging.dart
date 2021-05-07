
import 'package:coopscmconsole/screens/sabetwo.dart';
import 'package:coopscmconsole/screens/saveusers.dart';


import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

final FirebaseAuth _auth = FirebaseAuth.instance;

/// Entrypoint example for various sign-in flows with Firebase.
class SignInPage extends StatefulWidget {
  /// The page title.
  final String title = 'Sign In & Out';

  @override
  State<StatefulWidget> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  User user;

  @override
  void initState() {
    _auth.userChanges().listen((event) => setState(() => user = event));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          Builder(builder: (BuildContext context) {
            return FlatButton(
              textColor: Theme.of(context).buttonColor,
              onPressed: () async {
                final User user = _auth.currentUser;
                if (user == null) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('No hay personas Logeadas'),
                  ));
                  return;
                }
                await _signOut();

                final String uid = user.uid;
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('$uid salio con suceso.'),
                ));
              },
              child: const Text('Salir'),
            );
          })
        ],
      ),
      body: Builder(builder: (BuildContext context) {
        return ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            _UserInfoCard(user),
            _OtherProvidersSignInSection(),
            //_AddUser(),
          ],
        );
      }),
    );
  }

  // Example code for sign out.
  Future<void> _signOut() async {
    await _auth.signOut();
  }
}

class _UserInfoCard extends StatefulWidget {
  final User user;

  const _UserInfoCard(this.user);

  @override
  _UserInfoCardState createState() => _UserInfoCardState();
}

class _UserInfoCardState extends State<_UserInfoCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Informacion del Usuario',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  if (widget.user != null)
                    if (widget.user.photoURL != null)
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(bottom: 8),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(widget.user.photoURL),
                          radius: 25.0,
                        ),
                      )
                    else
                      Align(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.only(bottom: 8),
                          color: Colors.black,
                          child: const Text(
                            'No image',
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                  Text(widget.user == null
                      ? 'Not signed in'
                      : '${widget.user.isAnonymous ? 'User is anonymous\n\n' : ''}'
                          'Email: ${widget.user.email} (verified: ${widget.user.emailVerified})\n'
                          'Telefono numero: ${widget.user.phoneNumber}\n'
                          'Nombre: ${widget.user.displayName}\n'
                          'Ultima entrada: ${widget.user.metadata.lastSignInTime}\n',
                          style: TextStyle(
                            color: Colors.limeAccent
                          ) ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              width: 150,
              height: 150,
            ),
          ],
        ),
      ),
    );
  }
}

class _OtherProvidersSignInSection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OtherProvidersSignInSectionState();
}

class _OtherProvidersSignInSectionState
    extends State<_OtherProvidersSignInSection> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton.icon(
                  icon: Icon(Icons.login),
                  
                  label: Text('Autenticacion con Google'),
                  onPressed: () async {
                    _signInWithGoogle();
                  },
                ),
              ),
              ElevatedButton.icon(
                onPressed: () { Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => SaveUsers()));







                  
                },
                icon: Icon(Icons.person_add),
                label: Text('Agregar Usuarios'),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Test2()));





                  
                },
                icon: Icon(Icons.search),
                label: Text('Busqueda de Usuarios'),
              ),
            ],
          )),
    );
  }

  //Example code of how to sign in with Google.
  Future<void> _signInWithGoogle() async {
    try {
      UserCredential userCredential;

      if (kIsWeb) {
        var googleProvider = GoogleAuthProvider();
        userCredential = await _auth.signInWithPopup(googleProvider);
      } else {
        final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final googleAuthCredential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        userCredential = await _auth.signInWithCredential(googleAuthCredential);
      }

      final user = userCredential.user;
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Sign In ${user.displayName} with Google'),
      ));
    } catch (e) {
      print(e);
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to sign in with Google: $e'),
        ),
      );
    }
  }
}

class _AddUser extends StatefulWidget {
  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<_AddUser> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Text('hola'),
    );
  }
}
