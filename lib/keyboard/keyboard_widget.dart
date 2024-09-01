import 'package:flutter/material.dart';

 const List<String> nums = [
  '2', '4', '9',
  '6', '1', '5',
  '8', '3', '0',
  '7', '→', 'C',
];

// 自定义键盘的高度
 const double keyboardHeight = 200.0;

class CustomKeyboardWidget extends StatelessWidget {
  final Function(String) onKeyPressed;



  const CustomKeyboardWidget({super.key, required this.onKeyPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Container(
        color: Colors.grey[200],
        child: Padding(
          padding:  const EdgeInsets.all(10),
          child: GridView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: false,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: nums.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio:  3,
                  crossAxisCount: 3),
              itemBuilder: (context, index) {
                String keyLabel = nums[index];
                return InkWell(
                  onTap: () => onKeyPressed(keyLabel),
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(1.0),
                    color: keyLabel == '→' || keyLabel == 'C' ? Colors.red : Colors.white,
                    child: Text(
                      keyLabel,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}

class CustomKeyboardApp extends StatelessWidget {
  const CustomKeyboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CustomKeyBoardPage(),
    );
  }
}

class CustomKeyBoardPage extends StatefulWidget {
  const CustomKeyBoardPage({super.key});

  @override
  State<CustomKeyBoardPage> createState() => _CustomKeyBoardPageState();
}

class _CustomKeyBoardPageState extends State<CustomKeyBoardPage> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_focusNodeChange);
  }

  void _focusNodeChange() {
    if (_focusNode.hasFocus) {
      _showOverlay();
    } else {
      _removeOverlay();
    }
  }

  void _showOverlay() {
   _overlayEntry = _createOverlayEntry();
    if (Overlay.of(context) != null) {
      Overlay.of(context).insert(_overlayEntry!);
    } else {
      print("No Overlay widget found.");
    }
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry?.dispose();
    _overlayEntry = null;
  }

  void _handleKeyPress(String key)  {
    setState(() {
      switch (key)  {
        case '→':
          String result = _controller.text;
          if (result.isNotEmpty) {
            _controller.text = _controller.text.substring(0,  _controller.text.length  -1);
          }
          break;
        case 'C':
          _controller.clear();
          break;
        default:
          if (int.tryParse(key) != null)  {
            _controller.text  += key;
          }
      }
    });
  }

  OverlayEntry _createOverlayEntry() {

     return OverlayEntry(builder: (context) {
      return Positioned(
          left: 0,
          right: 0,
          bottom: MediaQuery.of(context).viewInsets.bottom,
          child: Material(
            elevation: 0.4,
            child: SizedBox(
              height: keyboardHeight,
              child: CustomKeyboardWidget(
                onKeyPressed: (String result) {
                  _handleKeyPress(result);
                },
              ),
            ),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () { // 使键盘失去焦点
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Custom Keyboard'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                focusNode: _focusNode,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Enter a number'),
                readOnly: true,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                  onPressed: () {
                    final enteredNumber = _controller.text;
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('You entered: $enteredNumber')));
                  },
                  child: const Text('Submit'))
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.removeListener(_focusNodeChange);
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }
}
