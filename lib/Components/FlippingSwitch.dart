import 'dart:math';
import 'package:flutter/material.dart';

class FlippingSwitch extends StatefulWidget {
  final Color color;
  final Color background;
  final IconData leftLabel;
  final IconData rightLabel;
  final double width;
  final double height;
  final Function(bool isLeftActive) onChanged;

  FlippingSwitch(
      {required this.color,
      required this.background,
      required this.leftLabel,
      required this.rightLabel,
      required this.onChanged,
      required this.width,
      required this.height,
      });

  @override
  State<FlippingSwitch> createState() => _FlippingSwitchState();
}

class _FlippingSwitchState extends State<FlippingSwitch>
    with TickerProviderStateMixin {
  final double _maxTiltAngle = pi / 6;
  late double _directionMultip = 1.0;
  late AnimationController _tiltController;
  Animation? _tiltAnimation;
  late AnimationController _flippController;
  @override
  void initState() {
    _tiltController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
      reverseDuration: Duration(milliseconds: 1500),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _tiltController.reverse();
        }
      });
    _tiltAnimation = CurvedAnimation(
        parent: _tiltController,
        curve: Curves.easeOut,
        reverseCurve: Curves.elasticOut.flipped);
    _flippController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _jumpToMode(true);
  }

  @override
  void dispose() {
    _tiltController.dispose();
    _flippController.dispose();
    super.dispose();
  }

  void _jumpToMode(bool leftEnabled) {
    _flippController.value = leftEnabled ? 1.0 : 0.0;
  }

  void _flipSwitch() {
    if (_flippController.isCompleted) {
      _directionMultip = -1;
      _tiltController.forward();
      _flippController.reverse();
      widget.onChanged.call(false);
    } else {
      _directionMultip = 1;
      _tiltController.forward();
      _flippController.forward();
      widget.onChanged.call(true);
    }
  }

  @override
  Widget build(BuildContext context) {
   
    return AnimatedBuilder(
      animation: _tiltAnimation as Listenable,
      builder: (context, tabs) {
        return Transform(
       
          transform: Matrix4.identity()..setEntry(3, 2, 0.001)..rotateY( _tiltAnimation!.value*_maxTiltAngle*_directionMultip),
          alignment: FractionalOffset(0.5,1.0),
          child: tabs ,

        );

      },
      child: Stack(children: [
        _buildTabsBackground(),
        AnimatedBuilder(
          animation: _flippController,
          builder: (context, child) {
            return _buildFlippingSwitch(_flippController.value * pi);
          },
        ),
      ]),
    );
  }

  Widget _buildTabsBackground() {
    var _iconSize=(widget.height*45/64).roundToDouble();
    return InkWell(
      onTap: _flipSwitch,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: widget.background,
            borderRadius: BorderRadius.circular(32),
            border: Border.all(width: (widget.width*5/250).roundToDouble(), color: widget.color)),
        child: Row(
          children: [
            Expanded(
                child: Center(
              child: Icon(
                widget.leftLabel,
                  color: widget.color,
                  size: _iconSize, 
              ),
            )),
            Expanded(
                child: Center(
              child: Icon(
                widget.rightLabel,
                  color: widget.color,
                
                  size: _iconSize,

              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildFlippingSwitch(double angle) {
    final isLeft = angle > (pi / 2);
    final transformAngle = isLeft ? angle - pi : angle;
    return Positioned(
      top: 0,
      bottom: 0,
      right: isLeft ? null : 0,
      left: isLeft ? 0 : null,
      child: Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.002)
          ..rotateY(transformAngle),
        alignment:
            isLeft ? FractionalOffset(1.0, 1.0) : FractionalOffset(0.0, 1),
        child: Container(
          width: widget.width/2,
          decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.only(
                topRight: isLeft ? Radius.zero : Radius.circular(32),
                bottomRight: isLeft ? Radius.zero : Radius.circular(32),
                topLeft: isLeft ? Radius.circular(32) : Radius.zero,
                bottomLeft: isLeft ? Radius.circular(32) : Radius.zero,
              )),
          child: Center(
            child: Icon(
              isLeft ? widget.leftLabel : widget.rightLabel,
              
                color: widget.background,
                size: (widget.height*45/64).roundToDouble(),
        
        
            ),
          ),
        ),
      ),
    );
  }
}
