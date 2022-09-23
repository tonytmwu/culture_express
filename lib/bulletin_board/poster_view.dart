import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PosterView extends StatefulWidget {

  String? img;
  String? caption;
  String? city;
  String? venue;
  String? startDate;
  String? endDate;

  PosterView({Key? key, this.img, this.caption, this.city, this. venue, this.startDate, this.endDate}) : super(key: key);

  @override
  State<PosterView> createState() => _PosterViewState();
}

class _PosterViewState extends State<PosterView> {

  Widget _showPosterImageWidget() {
    return CachedNetworkImage(
      imageUrl: widget.img ?? "",
      width: MediaQuery.of(context).size.width,
      fit: BoxFit.contain,
      placeholder: (context, url) => Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          height: 300,
          child: const SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(),
          )
      ),
    );
  }

  Widget _showEmptyImageWidget() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 300,
      alignment: Alignment.center,
      child: const Icon(Icons.ac_unit_sharp),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 5),
      child: Card(
        elevation: 10,
        child:  Column(
          children: <Widget>[
            Container(
              child: (widget.img ?? "").startsWith("http") ? _showPosterImageWidget() : _showEmptyImageWidget(),
            ),

            const SizedBox(height: 5,),

            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 5, right: 5, bottom: 3),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Text(widget.caption ?? "", style: const TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),),
                  ),

                  const SizedBox(height: 10,),

                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Text((widget.city?.isNotEmpty == true) ? "${widget.city ?? ""} / ${widget.venue ?? ""}" : widget.venue ?? "",
                      style: const TextStyle(fontSize: 18, color: Colors.black,),),
                  ),


                  const SizedBox(height: 5,),

                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Text("${widget.startDate ?? ""} ~ ${widget.endDate ?? ""}", style: const TextStyle(fontSize: 18, color: Colors.black),),
                  ),
                ],
              ),
            )
          ],
        ),
      )
      
    );
  }



}
