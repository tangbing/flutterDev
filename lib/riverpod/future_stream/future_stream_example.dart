// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// final articleFutureProvider = FutureProvider.autoDispose((ref) async =>
//     await Dio()
//         .get('https://www.wanandroid.com/article/list/0/json')
//         .then((res) => res.data));
//
// final articleStreamProvider = StreamProvider.autoDispose((ref) async* {
//   final response =
//       await Dio().get('https://www.wanandroid.com/article/list/0/json');
//   yield response.data;
// });
//
// void main() {
//   runApp(const ProviderScope(child: MyApp()));
// }
//
// class MyApp extends ConsumerWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Riverpod Demo'),
//         ),
//         body: const Row(
//           children: [
//             Expanded(child: FutureProviderExample()),
//             Expanded(child: StreamProviderExample())
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class FutureProviderExample extends ConsumerWidget {
//   const FutureProviderExample({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final responseAsyncValue = ref.watch(articleFutureProvider);
//     return Center(
//       child: SingleChildScrollView(
//         child: responseAsyncValue.when(
//             data: (data) => Text('Data: $data'),
//             error: (error, stackTrace) => Text('Error:  $stackTrace'),
//             loading: () => const CircularProgressIndicator()),
//       ),
//     );
//   }
// }
//
// class StreamProviderExample extends ConsumerWidget {
//   const StreamProviderExample({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final responseStreamValue = ref.watch(articleStreamProvider);
//     return Center(
//       child: SingleChildScrollView(
//         child: responseStreamValue.when(
//             data: (data) => Text('Data: $data'),
//             error: (error, stackTrace) => Text('Error:  $stackTrace'),
//             loading: () => const CircularProgressIndicator()),
//       ),
//     );
//   }
// }
//
// class ConsumerStatefulWidgetExample extends ConsumerStatefulWidget {
//   const ConsumerStatefulWidgetExample({super.key});
//   @override
//   ConsumerState<ConsumerStatefulWidget> createState()  => _ConsumerStatefulWidgetExampleState();
// }
// class _ConsumerStatefulWidgetExampleState extends ConsumerState  {
//   @override
//   Widget build(BuildContext context) {
//     final value = ref.watch(articleFutureProvider);
//     return const Placeholder();
//   }
// }
//
// class Example extends StatelessWidget {
//   const Example({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer(builder: (context, ref, child){
//        final  AsyncValue<Example> example = ref.watch(articleFutureProvider as ProviderListenable<AsyncValue<Example>>);
//        return  Center(
//          child: switch(example)  {
//            AsyncData(:final value) => articleFutureProvider,
//            AsyncError() => Text('Oops, something unexpected happened'),,
//            AsyncLoading() => const CircularProgressIndicator(),,
//          },
//        );
//        final value =  ref.watch(articleFutureProvider);
//        return  Text(value);
//     });
//   }
// }
//
