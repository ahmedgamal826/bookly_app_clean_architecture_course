import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ====== State Provider ======
// هنا عرفنا "مزود" للعداد
final counterProvider = StateProvider<int>((ref) => 0);

class CounterScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // نقرأ قيمة العداد
    final counter = ref.watch(counterProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Riverpod Counter")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Value: $counter", style: TextStyle(fontSize: 24)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    ref.read(counterProvider.notifier).state--;
                  },
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    ref.read(counterProvider.notifier).state++;
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
