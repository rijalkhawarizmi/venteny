
import 'package:flutter/material.dart';

import '../../core/config/color_app.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();





class CustomSnackbar {

   static void infoConnectionSnackBar(
      {required String title,
      required Color backgroundColor,
      Duration duration = const Duration(seconds: 3)}) {
    scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
      content: Text(title,style: TextStyle(color: ColorApp.white,fontWeight: FontWeight.bold),),
      backgroundColor: backgroundColor,
      duration: duration,
      action: SnackBarAction(
          label: "OK",
          textColor: ColorApp.white,
          onPressed: () {
            scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
          }),
      behavior: SnackBarBehavior.floating,
    ));
  }


  static void customSnackBar(
    BuildContext context, {
    required Widget customSnackBar,
    Duration duration = const Duration(seconds: 3),
    EdgeInsetsGeometry margin = const EdgeInsets.all(0),
    Color backgroundColor = Colors.green,
  }) {
    // Overlay entry untuk menampilkan snackbar
    late OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: SafeArea(
            child: _AnimatedSnackbar(
              margin: margin,
              duration: duration,
              customSnackBar: customSnackBar,
              backgroundColor: backgroundColor,
              onDismiss: () {
                overlayEntry.remove();
              },
            ),
          ),
        );
      },
    );

    // Tambahkan overlay ke layar
    Overlay.of(context).insert(overlayEntry);

    // Hapus snackbar setelah durasi selesai
    Future.delayed(duration + const Duration(milliseconds: 300), () {
      overlayEntry.remove();
    });
  }
}

class _AnimatedSnackbar extends StatefulWidget {
  final Duration duration;
  final Widget customSnackBar;
  final EdgeInsetsGeometry margin;
  final Color backgroundColor;
  final VoidCallback onDismiss;

  const _AnimatedSnackbar({
    required this.duration,
    required this.customSnackBar,
    required this.margin,
    required this.backgroundColor,
    required this.onDismiss,
  });

  @override
  State<_AnimatedSnackbar> createState() => _AnimatedSnackbarState();
}

class _AnimatedSnackbarState extends State<_AnimatedSnackbar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Inisialisasi AnimationController
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Slide-in dari atas
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack, // Tambahkan efek bounce
    ));

    // Scale animation untuk efek zoom-in
    _scaleAnimation = Tween<double>(
      begin: 0.9,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));

    // Jalankan animasi saat snackbar ditampilkan
    _controller.forward();

    // Mulai animasi reverse sebelum snackbar dihapus
    Future.delayed(widget.duration, () {
      _controller.reverse();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    // Ketika snackbar di-tap, animasi keluar (ke atas)
    _controller.reverse().then((_) {
      widget.onDismiss();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: SlideTransition(
        position: _slideAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            margin: widget.margin,
            child: Material(
              borderRadius: BorderRadius.circular(8),
              color: widget.backgroundColor,
              elevation: 2,
              child: widget.customSnackBar,
            ),
          ),
        ),
      ),
    );
  }
}






// class CustomSnackbar {
//   static void show(BuildContext context, {
//     required String title,
//     required String message,
//     Color backgroundColor = Colors.black87,
//     Color textColor = Colors.white,
//     Duration duration = const Duration(seconds: 3),
//   }) {
//     // Overlay entry untuk menampilkan snackbar
//     OverlayEntry overlayEntry = OverlayEntry(
//       builder: (context) {
//         return Positioned(
//           top: 0,
//           left: 0,
//           right: 0,
//           child: SafeArea(
//             child: _AnimatedSnackbar(
//               title: title,
//               message: message,
//               backgroundColor: backgroundColor,
//               textColor: textColor,
//               duration: duration,
//             ),
//           ),
//         );
//       },
//     );

//     // Tambahkan overlay ke layar
//     Overlay.of(context).insert(overlayEntry);

//     // Hapus snackbar setelah durasi selesai
//     Future.delayed(duration + const Duration(milliseconds: 300), () {
//       overlayEntry.remove();
//     });
//   }
// }

// class _AnimatedSnackbar extends StatefulWidget {
//   final String title;
//   final String message;
//   final Color backgroundColor;
//   final Color textColor;
//   final Duration duration;

//   const _AnimatedSnackbar({
//     required this.title,
//     required this.message,
//     required this.backgroundColor,
//     required this.textColor,
//     required this.duration,
//   });

//   @override
//   State<_AnimatedSnackbar> createState() => _AnimatedSnackbarState();
// }

// class _AnimatedSnackbarState extends State<_AnimatedSnackbar>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<Offset> _slideAnimation;
//   late Animation<double> _fadeAnimation;
//   late Animation<double> _scaleAnimation;

//   @override
//   void initState() {
//     super.initState();

//     // Inisialisasi AnimationController
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 300),
//       reverseDuration: const Duration(milliseconds: 300),
//       vsync: this,
//     );

//     // Slide-in dari atas
//     _slideAnimation = Tween<Offset>(
//       begin: const Offset(0, -1),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeOutBack, // Tambahkan efek bounce
//     ));

//     // Fade-in animasi
//     _fadeAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeIn,
//     ));

//     // Scale animation untuk efek zoom-in
//     _scaleAnimation = Tween<double>(
//       begin: 0.9,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _controller,
//       curve: Curves.elasticOut,
//     ));

//     // Jalankan animasi saat snackbar ditampilkan
//     _controller.forward();

//     // Mulai animasi reverse sebelum snackbar dihapus
//     Future.delayed(widget.duration, () {
//       _controller.reverse();
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FadeTransition(
//       opacity: _fadeAnimation,
//       child: SlideTransition(
//         position: _slideAnimation,
//         child: ScaleTransition(
//           scale: _scaleAnimation,
//           child: Material(
//             color: widget.backgroundColor,
//             elevation: 10,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     widget.title,
//                     style: TextStyle(
//                       color: widget.textColor,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     widget.message,
//                     style: TextStyle(
//                       color: widget.textColor,
//                       fontSize: 14,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



// class CustomSnackbar {
//   static void show(
//     BuildContext context, {
//     required String title,
//     required String message,
//     Color backgroundColor = Colors.black87,
//     Color textColor = Colors.white,
//     Duration duration = const Duration(seconds: 3),
//   }) {
//     late OverlayEntry overlayEntry; // Gunakan 'late' untuk mendeklarasikan sebelum digunakan

//     overlayEntry = OverlayEntry(
//       builder: (context) {
//         return Positioned(
//           top: 0,
//           left: 0,
//           right: 0,
//           child: SafeArea(
//             child: _AnimatedSnackbar(
//               title: title,
//               message: message,
//               backgroundColor: backgroundColor,
//               textColor: textColor,
//               duration: duration,
//               onDismiss: () {
//                 overlayEntry.remove(); // Hapus snackbar saat dismiss dipanggil
//               },
//             ),
//           ),
//         );
//       },
//     );

//     // Tambahkan overlay ke layar
//     Overlay.of(context).insert(overlayEntry);

//     // Hapus snackbar secara otomatis setelah durasi selesai jika belum dihapus
//     Future.delayed(duration + const Duration(milliseconds: 300), () {
//       overlayEntry.remove();
//     });
//   }
// }

// class _AnimatedSnackbar extends StatefulWidget {
//   final String title;
//   final String message;
//   final Color backgroundColor;
//   final Color textColor;
//   final Duration duration;
//   final VoidCallback onDismiss;

//   const _AnimatedSnackbar({
//     required this.title,
//     required this.message,
//     required this.backgroundColor,
//     required this.textColor,
//     required this.duration,
//     required this.onDismiss,
//   });

//   @override
//   State<_AnimatedSnackbar> createState() => _AnimatedSnackbarState();
// }

// class _AnimatedSnackbarState extends State<_AnimatedSnackbar>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<Offset> _slideAnimation;

//   @override
//   void initState() {
//     super.initState();

//     // Inisialisasi AnimationController
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 300),
//       reverseDuration: const Duration(milliseconds: 300),
//       vsync: this,
//     );

//     // Slide-in dari atas
//     _slideAnimation = Tween<Offset>(
//       begin: const Offset(0, -1),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeOutBack, // Tambahkan efek bounce
//     ));

//     // Jalankan animasi saat snackbar ditampilkan
//     _controller.forward();

//     // Jalankan animasi reverse setelah durasi selesai
//     Future.delayed(widget.duration, () {
//       _controller.reverse().then((_) {
//         widget.onDismiss(); // Panggil callback untuk menghapus snackbar
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: widget.onDismiss, // Snackbar bisa ditekan untuk dihapus
//       child: SlideTransition(
//         position: _slideAnimation,
//         child: Material(
//           color: widget.backgroundColor,
//           elevation: 10,
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     widget.title,
//                     style: TextStyle(
//                       color: widget.textColor,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     widget.message,
//                     style: TextStyle(
//                       color: widget.textColor,
//                       fontSize: 14,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
