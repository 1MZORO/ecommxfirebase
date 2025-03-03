
Reloaded 4 of 781 libraries in 2,198ms (compile: 88 ms, reload: 1077 ms, reassemble: 885 ms).
I/ImeTracker(17492): com.example.ecomxfirebase:9396361: onRequestShow at ORIGIN_CLIENT_SHOW_SOFT_INPUT reason SHOW_SOFT_INPUT
D/InputMethodManager(17492): showSoftInput() view=io.flutter.embedding.android.FlutterView{bb76bad VFE...... .F...... 0,0-720,1582 #1 aid=1073741824} flags=0 reason=SHOW_SOFT_INPUT
D/InputConnectionAdaptor(17492): The input method toggled cursor monitoring on
I/AssistStructure(17492): Flattened final assist data: 460 bytes, containing 1 windows, 3 views
D/InputConnectionAdaptor(17492): The input method toggled cursor monitoring off
D/InputConnectionAdaptor(17492): The input method toggled cursor monitoring on
D/InsetsController(17492): show(ime(), fromIme=true)
I/ImeTracker(17492): com.example.ecomxfirebase:9396361: onCancelled at PHASE_CLIENT_APPLY_ANIMATION
I/FirebaseAuth(17492): Logging in as test@gmail.com with empty reCAPTCHA token
W/System  (17492): Ignoring header X-Firebase-Locale because its value was null.
E/RecaptchaCallWrapper(17492): Initial task failed for action RecaptchaAction(action=signInWithPassword)with exception - The supplied auth credential is incorrect, malformed or has expired.
E/flutter (17492): [ERROR:flutter/runtime/dart_vm_initializer.cc(40)] Unhandled Exception: Exception: [firebase_auth/invalid-credential] The supplied auth credential is incorrect, malformed or has expired.
E/flutter (17492): #0      AuthService.signInWthEmail (package:ecomxfirebase/Services/AuthServices.dart:15:7)
E/flutter (17492): <asynchronous suspension>
E/flutter (17492): #1      _LoginScreenState.build.<anonymous closure> (package:ecomxfirebase/Screens/LoginScreen.dart:73:31)
E/flutter (17492): <asynchronous suspension>
E/flutter (17492): 
