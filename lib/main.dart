import 'package:flutter/material.dart';

void main() => runApp(XontikApp());

class XontikApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: Locale(WidgetsBinding.instance.platformDispatcher.locale.languageCode),
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.redAccent,
      ),
      home: LoginPage(), // نبدأ بصفحة تسجيل الدخول الراقية
    );
  }
}

// --- 1. واجهة تسجيل الدخول الراقية ---
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isAr = Localizations.localeOf(context).languageCode == 'ar';
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        decoration: const BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, colors: [Color(0xFF1A1A1A), Colors.black]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("XONTIK", style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold, letterSpacing: 4, color: Colors.white)),
            const SizedBox(height: 10),
            Text(isAr ? "سجل دخولك لاستكشاف الفيديوهات" : "Log in to explore videos", style: TextStyle(color: Colors.grey[400])),
            const SizedBox(height: 50),
            _loginButton(Icons.phone_android, isAr ? "استخدام الهاتف / البريد" : "Use Phone / Email"),
            _loginButton(Icons.g_mobiledata, isAr ? "المتابعة باستخدام Google" : "Continue with Google", color: Colors.white, textColor: Colors.black),
            _loginButton(Icons.facebook, isAr ? "المتابعة باستخدام Facebook" : "Continue with Facebook", color: const Color(0xFF1877F2)),
            const SizedBox(height: 30),
            TextButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TikTokHome())),
              child: Text(isAr ? "تخطي الآن >" : "Skip for now >", style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loginButton(IconData icon, String text, {Color color = const Color(0xFF2C2C2C), Color textColor = Colors.white}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      height: 55,
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(30), border: Border.all(color: Colors.white12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: textColor),
          const SizedBox(width: 10),
          Text(text, style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

// --- 2. واجهة الفيديوهات الرئيسية (تيك توك كاملة) ---
class TikTokHome extends StatefulWidget {
  @override
  _TikTokHomeState createState() => _TikTokHomeState();
}

class _TikTokHomeState extends State<TikTokHome> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    bool isAr = Localizations.localeOf(context).languageCode == 'ar';
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical, // التمرير للأعلى والأسفل
        itemCount: 10,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Container(color: index % 2 == 0 ? Colors.black : const Color(0xFF121212), child: Center(child: Icon(Icons.play_circle_outline, size: 80, color: Colors.white.withOpacity(0.2)))),
              // الأزرار الجانبية في اليسار
              Positioned(
                left: 15, bottom: 100,
                child: Column(
                  children: [
                    _profileWithPlus(),
                    _sideAction(Icons.favorite, "2.5M", color: Colors.red),
                    _sideAction(Icons.comment, "120K"),
                    _sideAction(Icons.share, "Share"),
                  ],
                ),
              ),
              // وصف الفيديو في اليمين
              Positioned(
                right: 15, bottom: 90,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text("@User_Pro", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 5),
                    Text(isAr ? "هذا التطبيق مذهل! 🚀 #Xontik" : "This app is amazing! 🚀 #Xontik", style: const TextStyle(fontSize: 14)),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.home), label: isAr ? 'الرئيسية' : 'Home'),
          BottomNavigationBarItem(icon: const Icon(Icons.search), label: isAr ? 'اكتشف' : 'Discover'), // زر البحث المفقود
          BottomNavigationBarItem(icon: _addIcon(), label: ''),
          BottomNavigationBarItem(icon: const Icon(Icons.inbox), label: isAr ? 'الرسائل' : 'Inbox'),
          BottomNavigationBarItem(icon: const Icon(Icons.person), label: isAr ? 'الملف الشخصي' : 'Profile'),
        ],
      ),
    );
  }

  Widget _sideAction(IconData icon, String label, {Color color = Colors.white}) => Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: Column(children: [Icon(icon, size: 35, color: color), Text(label, style: const TextStyle(fontSize: 12))]));

  Widget _profileWithPlus() => Stack(alignment: Alignment.bottomCenter, children: [
    const CircleAvatar(radius: 25, backgroundColor: Colors.white, child: CircleAvatar(radius: 23, backgroundColor: Colors.grey, icon: Icon(Icons.person))),
    Transform.translate(offset: const Offset(0, 8), child: Container(decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle), child: const Icon(Icons.add, size: 18, color: Colors.white))),
  ]);

  Widget _addIcon() => Container(width: 45, height: 28, child: Stack(children: [
    Container(margin: const EdgeInsets.only(left: 10), decoration: BoxDecoration(color: Colors.cyan, borderRadius: BorderRadius.circular(8))),
    Container(margin: const EdgeInsets.only(right: 10), decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(8))),
    Center(child: Container(height: double.infinity, width: 30, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.add, color: Colors.black, size: 20))),
  ]));
}

