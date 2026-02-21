import 'package:flutter/material.dart';

void main() => runApp(const XontikMasterpiece());

class XontikMasterpiece extends StatelessWidget {
  const XontikMasterpiece({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
      home: const AuthScreen(),
    );
  }
}

// --- 1. واجهة تسجيل الدخول ---
class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: Column(
          children: [
            const Spacer(),
            const Text("XONTIK", style: TextStyle(fontSize: 65, fontWeight: FontWeight.bold, letterSpacing: 6)),
            const SizedBox(height: 10),
            const Text("عالم المبدعين بين يديك", style: TextStyle(color: Colors.white54)),
            const SizedBox(height: 60),
            _socialBtn(Icons.person_outline, "استخدام الهاتف / البريد"),
            _socialBtn(Icons.g_mobiledata, "المتابعة باستخدام Google"),
            _socialBtn(Icons.apple, "المتابعة باستخدام Apple"),
            const Spacer(),
            GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => const MainTikTokScaffold())),
              child: const Padding(
                padding: EdgeInsets.only(bottom: 35),
                child: Text("إنشاء حساب جديد", style: TextStyle(color: Color(0xFFeb3349), fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _socialBtn(IconData icon, String label) => Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(13),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.white12)),
    child: Row(children: [Icon(icon, size: 26), Expanded(child: Text(label, textAlign: TextAlign.center))]),
  );
}

// --- 2. الهيكل الرئيسي مع خيارات النشر ---
class MainTikTokScaffold extends StatefulWidget {
  const MainTikTokScaffold({super.key});
  @override
  State<MainTikTokScaffold> createState() => _MainTikTokScaffoldState();
}

class _MainTikTokScaffoldState extends State<MainTikTokScaffold> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [const TikTokFeedView(), const Center(child: Text("اكتشف")), Container(), const Center(child: Text("الرسائل")), const ProfileScreen()];

  void _onItemTapped(int index) {
    if (index == 2) {
      _showUploadSheet(context);
    } else {
      setState(() => _selectedIndex = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'الرئيسية'),
          const BottomNavigationBarItem(icon: Icon(Icons.search), label: 'اكتشف'),
          BottomNavigationBarItem(icon: _plusIcon(), label: ''),
          const BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'صندوق الوارد'),
          const BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'الملف'),
        ],
      ),
    );
  }

  Widget _plusIcon() => SizedBox(width: 45, height: 28, child: Stack(children: [
    Container(margin: const EdgeInsets.only(left: 10), width: 38, decoration: BoxDecoration(color: const Color(0xFF2af1f7), borderRadius: BorderRadius.circular(7))),
    Container(margin: const EdgeInsets.only(right: 10), width: 38, decoration: BoxDecoration(color: const Color(0xFFeb3349), borderRadius: BorderRadius.circular(7))),
    Center(child: Container(width: 38, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(7)), child: const Icon(Icons.add, color: Colors.black, size: 20))),
  ]));

  void _showUploadSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      builder: (context) => Container(
        height: 200,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          _uploadOption(Icons.videocam, "كاميرا", Colors.purple),
          _uploadOption(Icons.image, "صور", Colors.blue),
          _uploadOption(Icons.upload_file, "فيديو", Colors.redAccent),
        ]),
      ),
    );
  }
  Widget _uploadOption(IconData i, String t, Color c) => Column(mainAxisSize: MainAxisSize.min, children: [CircleAvatar(radius: 30, backgroundColor: c.withOpacity(0.2), child: Icon(i, color: c)), Text(t)]);
}

// --- 3. الملف الشخصي (أزرار وردية دائرية ومشاركة فعالة) ---
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black, actions: [IconButton(icon: const Icon(Icons.menu), onPressed: () {})]),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
          const SizedBox(height: 15),
          const Text("@xontik_pro", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [_stat("150", "أتابع"), _stat("1.5M", "متابعين")]),
          const SizedBox(height: 25),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            _pBtn("تعديل الملف", const Color(0xFFeb3349), () {}), // زر وردي راقي
            const SizedBox(width: 10),
            _pBtn("مشاركة", Colors.white10, () => _share(context)), // زر بحواف دائرية
          ]),
          const Divider(height: 40, color: Colors.white12),
          Expanded(child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3), itemCount: 6, itemBuilder: (c, i) => Container(color: Colors.white10, margin: const EdgeInsets.all(1)))),
        ],
      ),
    );
  }
  Widget _stat(String v, String l) => Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Column(children: [Text(v, style: const TextStyle(fontWeight: FontWeight.bold)), Text(l, style: const TextStyle(color: Colors.grey))]));
  Widget _pBtn(String t, Color c, VoidCallback o) => GestureDetector(onTap: o, child: Container(padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12), decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(25)), child: Text(t, style: const TextStyle(fontWeight: FontWeight.bold))));
  void _share(BuildContext context) => showModalBottomSheet(context: context, builder: (c) => const ListTile(title: Text("تم نسخ رابط الملف الشخصي!")));
}

// --- 4. محرك الفيديوهات (إعادة كافة الأزرار الجانبية) ---
class TikTokFeedView extends StatelessWidget {
  const TikTokFeedView({super.key});
  @override
  Widget build(BuildContext context) => PageView.builder(scrollDirection: Axis.vertical, itemBuilder: (c, i) => const VideoItem());
}

class VideoItem extends StatelessWidget {
  const VideoItem({super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(fit: StackFit.expand, children: [
      Container(decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.blueGrey, Colors.black], begin: Alignment.topCenter))),
      
      // الأزرار الجانبية المفقودة
      Positioned(right: 10, bottom: 100, child: Column(children: [
        _sideUser(),
        const SizedBox(height: 20),
        _sideIcon(Icons.favorite, "2.1M", Colors.red),
        _sideIcon(Icons.chat_bubble, "10K", Colors.white),
        _sideIcon(Icons.bookmark, "50K", Colors.amber),
        _sideIcon(Icons.share, "مشاركة", Colors.white),
        const SizedBox(height: 20),
        _musicDisc(), // الدائرة المتحركة
      ])),

      // معلومات الفيديو والصوت الأصلي
      Positioned(left: 15, bottom: 25, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text("@Xontik", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const Text("واجهة تيك توك مكتملة بنسبة 100% 🔥"),
        const SizedBox(height: 10),
        Row(children: const [Icon(Icons.music_note, size: 15), Text("الصوت الأصلي - Xontik Master")]),
      ])),
    ]);
  }
  Widget _sideUser() => Stack(clipBehavior: Clip.none, children: [
    const CircleAvatar(radius: 25, child: Icon(Icons.person)),
    Positioned(bottom: -10, left: 15, child: Container(decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle), child: const Icon(Icons.add, size: 20)))
  ]);
  Widget _sideIcon(IconData i, String l, Color c) => Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: Column(children: [Icon(i, size: 35, color: c), Text(l, style: const TextStyle(fontSize: 12))]));
  Widget _musicDisc() => Container(padding: const EdgeInsets.all(8), decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.black54), child: const Icon(Icons.music_note, size: 20));
}

