import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_app/screens/home/home.dart';
import 'package:stock_app/screens/login/login.dart';
import 'package:stock_app/screens/splash/splash.dart';
//import 'package:stock_app/screens/splash/splash.dart';
import 'package:splash_screen_package/splash_screen_package.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

Future<void> checkLoginStatus(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  await Future.delayed(const Duration(seconds: 1));
  if (isLoggedIn) {
    // Đã đăng nhập, chuyển sang màn hình HomeScreen
    if (context.mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  } else {
    // Chưa đăng nhập, chuyển sang màn hình LoginScreen
    if (context.mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }

  }
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home:SplashScreen(
        title: 'Splassssss',
        checkLoginStatus: checkLoginStatus,
      ),
      //home: LoginScreen(),
      //home: HomeScreen(),
    );
  }
}
/*
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/sunlight3d/splash_screen_package.git
git push -u origin master

git tag -a v0.0.1 -m "Phiên bản đầu tiên"
git push origin v0.0.1
* */
/*
Tôi có 1 ứng dụng flutter, muốn gọi Websocket đến url sau:
wss://localhost:7036/api/Quote/ws?page=${page}&limit=${limit}
Giá trị trả về là danh sách đối tượng, mỗi đối tượng có những trường sau:
int quoteId,string? Symbol,string? CompanyName,string? IndexName,
string? IndexSymbol,decimal MarketCap,string? SectorEn,string? IndustryEn,
string? Sector,string? Industry,string? StockType,decimal Price,decimal Change
decimal PercentChange,int Volume,DateTime TimeStamp
Viết cho tôi đoạn gọi webservice,viết cả Model(tên là RealtimeQuote), Repository, hiện dữ liệu lên datatable
Viết phần inject repository vào
Hướng dẫn cách gọi api từ App android đến localhost
* */

