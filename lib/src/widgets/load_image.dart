
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';


class LoadImage extends StatelessWidget {
 
  final String url;
  final double width;
  final double height;
  final int retryLimit;

  LoadImage({@required this.url,@required this.width,@required this.height,this.retryLimit=3});


  @override
  Widget build(BuildContext context) {
    return TransitionToImage(
            image: AdvancedNetworkImage(url,
                  retryLimit: retryLimit,
                  cacheRule: CacheRule(maxAge: const Duration(days: 7)),

            ),
            loadingWidgetBuilder: (_, double progress, __) =>
             Container(width:width,height:height,child: CircularProgressIndicator()),
            fit: BoxFit.contain,
            placeholder: const Icon(Icons.refresh),
            width:width,
            height: height,
            enableRefresh: true,  
            );
      }
}