import 'package:flutter/material.dart';
import 'package:modawan/core/theme/theme_constants.dart';

//Add this CustomPaint widget to the Widget Tree

class ModawanLogo extends StatelessWidget {
  const ModawanLogo(
      {super.key,
      required this.width,
      required this.color,
      this.labeled = false});
  final double width;
  final Color color;
  final bool labeled;

  @override
  Widget build(BuildContext context) {
    if (labeled) {
      return SizedBox(
        width: width - 0.125 *width,
        height: width,
        child: Column(
          children: [
            Flexible(
              
              flex: 7,
              child: AspectRatio(
                aspectRatio: 1,
                child: CustomPaint(
                  size: Size(width, width),
                  painter: _RPSCustomPainter(color: color),
                ),
              ),
            ),
            Expanded(
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text('Modawan | مدون',
                    style: TextStyle( color: color)),
              ),
            ),
          ],
        ),
      );
    }
    return CustomPaint(
      size: Size(width, width),
      painter: _RPSCustomPainter(color: color),
    );
  }
}

//Copy this CustomPainter code to the Bottom of the File
class _RPSCustomPainter extends CustomPainter {
  _RPSCustomPainter({this.color = AppColors.darkblue});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.8915595, size.height * 0.01506637);
    path_0.cubicTo(
        size.width * 0.8707440,
        size.height * 0.02455298,
        size.width * 0.8631726,
        size.height * 0.03069137,
        size.width * 0.8549702,
        size.height * 0.04389821);
    path_0.lineTo(size.width * 0.8446726, size.height * 0.06063929);
    path_0.lineTo(size.width * 0.8469821, size.height * 0.04668839);
    path_0.cubicTo(
        size.width * 0.8499286,
        size.height * 0.02901726,
        size.width * 0.8478214,
        size.height * 0.02920327,
        size.width * 0.8175476,
        size.height * 0.04892054);
    path_0.cubicTo(
        size.width * 0.7582500,
        size.height * 0.08761131,
        size.width * 0.7311250,
        size.height * 0.1354161,
        size.width * 0.7311250,
        size.height * 0.2016363);
    path_0.cubicTo(
        size.width * 0.7311250,
        size.height * 0.2380946,
        size.width * 0.7262917,
        size.height * 0.2358625,
        size.width * 0.7214583,
        size.height * 0.1973577);
    path_0.cubicTo(
        size.width * 0.7183036,
        size.height * 0.1731762,
        size.width * 0.7241905,
        size.height * 0.1413685,
        size.width * 0.7368036,
        size.height * 0.1156988);
    path_0.lineTo(size.width * 0.7445833, size.height * 0.09932976);
    path_0.lineTo(size.width * 0.7317560, size.height * 0.1060262);
    path_0.cubicTo(
        size.width * 0.6939107,
        size.height * 0.1255571,
        size.width * 0.6478631,
        size.height * 0.1878714,
        size.width * 0.6400833,
        size.height * 0.2299101);
    path_0.lineTo(size.width * 0.6365119, size.height * 0.2503714);
    path_0.lineTo(size.width * 0.6358810, size.height * 0.2338161);
    path_0.cubicTo(
        size.width * 0.6354583,
        size.height * 0.2139131,
        size.width * 0.6295714,
        size.height * 0.2187494,
        size.width * 0.6148512,
        size.height * 0.2507435);
    path_0.cubicTo(
        size.width * 0.6037083,
        size.height * 0.2751107,
        size.width * 0.6041310,
        size.height * 0.2687863,
        size.width * 0.6165357,
        size.height * 0.2243298);
    path_0.cubicTo(
        size.width * 0.6329345,
        size.height * 0.1661077,
        size.width * 0.6318810,
        size.height * 0.1638756,
        size.width * 0.6005536,
        size.height * 0.1927077);
    path_0.cubicTo(
        size.width * 0.5685940,
        size.height * 0.2224696,
        size.width * 0.5515631,
        size.height * 0.2520452,
        size.width * 0.5475679,
        size.height * 0.2853417);
    path_0.lineTo(size.width * 0.5446244, size.height * 0.3098952);
    path_0.lineTo(size.width * 0.5395780, size.height * 0.2950143);
    path_0.cubicTo(
        size.width * 0.5368446,
        size.height * 0.2868298,
        size.width * 0.5345315,
        size.height * 0.2767851,
        size.width * 0.5343214,
        size.height * 0.2726929);
    path_0.cubicTo(
        size.width * 0.5339006,
        size.height * 0.2501851,
        size.width * 0.4954226,
        size.height * 0.3162196,
        size.width * 0.4859607,
        size.height * 0.3560262);
    path_0.cubicTo(
        size.width * 0.4748167,
        size.height * 0.4025292,
        size.width * 0.4832274,
        size.height * 0.4827000,
        size.width * 0.5029923,
        size.height * 0.5163685);
    path_0.lineTo(size.width * 0.5101411, size.height * 0.5286452);
    path_0.lineTo(size.width * 0.5362137, size.height * 0.4843744);
    path_0.cubicTo(
        size.width * 0.5814202,
        size.height * 0.4073655,
        size.width * 0.6072798,
        size.height * 0.3755571,
        size.width * 0.7277619,
        size.height * 0.2485113);
    path_0.cubicTo(
        size.width * 0.7824345,
        size.height * 0.1908476,
        size.width * 0.8190179,
        size.height * 0.1454607,
        size.width * 0.8415179,
        size.height * 0.1080720);
    path_0.cubicTo(
        size.width * 0.8490833,
        size.height * 0.09523750,
        size.width * 0.8562321,
        size.height * 0.08537917,
        size.width * 0.8572857,
        size.height * 0.08630893);
    path_0.cubicTo(
        size.width * 0.8598095,
        size.height * 0.08872738,
        size.width * 0.8255357,
        size.height * 0.1532732,
        size.width * 0.8026190,
        size.height * 0.1884292);
    path_0.cubicTo(
        size.width * 0.7786488,
        size.height * 0.2256315,
        size.width * 0.7784345,
        size.height * 0.2260036,
        size.width * 0.7984107,
        size.height * 0.2122387);
    path_0.cubicTo(
        size.width * 0.8274286,
        size.height * 0.1923357,
        size.width * 0.8270060,
        size.height * 0.1947536,
        size.width * 0.7969405,
        size.height * 0.2207952);
    path_0.cubicTo(
        size.width * 0.7399583,
        size.height * 0.2700887,
        size.width * 0.6411369,
        size.height * 0.3989946,
        size.width * 0.5868869,
        size.height * 0.4942327);
    path_0.cubicTo(
        size.width * 0.5517732,
        size.height * 0.5561750,
        size.width * 0.5311673,
        size.height * 0.6255595,
        size.width * 0.5271720,
        size.height * 0.6949405);
    path_0.lineTo(size.width * 0.5248595, size.height * 0.7377202);
    path_0.lineTo(size.width * 0.5446244, size.height * 0.7215417);
    path_0.cubicTo(
        size.width * 0.5734304,
        size.height * 0.6981012,
        size.width * 0.6188452,
        size.height * 0.6802440,
        size.width * 0.6560655,
        size.height * 0.6774524);
    path_0.lineTo(size.width * 0.6861310, size.height * 0.6752202);
    path_0.lineTo(size.width * 0.6766667, size.height * 0.6659226);
    path_0.cubicTo(
        size.width * 0.6632143,
        size.height * 0.6530893,
        size.width * 0.6354583,
        size.height * 0.6428571,
        size.width * 0.6047619,
        size.height * 0.6396964);
    path_0.lineTo(size.width * 0.5786869, size.height * 0.6369048);
    path_0.lineTo(size.width * 0.6016071, size.height * 0.6264881);
    path_0.cubicTo(
        size.width * 0.6142202,
        size.height * 0.6207202,
        size.width * 0.6390298,
        size.height * 0.6104881,
        size.width * 0.6566964,
        size.height * 0.6039821);
    path_0.cubicTo(
        size.width * 0.7054762,
        size.height * 0.5857506,
        size.width * 0.7794881,
        size.height * 0.5342256,
        size.width * 0.7719167,
        size.height * 0.5236226);
    path_0.cubicTo(
        size.width * 0.7706548,
        size.height * 0.5215768,
        size.width * 0.7723393,
        size.height * 0.5189726,
        size.width * 0.7759167,
        size.height * 0.5178565);
    path_0.cubicTo(
        size.width * 0.7820119,
        size.height * 0.5158101,
        size.width * 0.8415179,
        size.height * 0.4497762,
        size.width * 0.8415179,
        size.height * 0.4451256);
    path_0.cubicTo(
        size.width * 0.8415179,
        size.height * 0.4440095,
        size.width * 0.8259583,
        size.height * 0.4460560,
        size.width * 0.8068214,
        size.height * 0.4495899);
    path_0.cubicTo(
        size.width * 0.7628750,
        size.height * 0.4577744,
        size.width * 0.7058988,
        size.height * 0.4620530,
        size.width * 0.7166190,
        size.height * 0.4564726);
    path_0.cubicTo(
        size.width * 0.7206131,
        size.height * 0.4544262,
        size.width * 0.7466845,
        size.height * 0.4443815,
        size.width * 0.7744405,
        size.height * 0.4343369);
    path_0.cubicTo(
        size.width * 0.8368929,
        size.height * 0.4116435,
        size.width * 0.8688512,
        size.height * 0.3937863,
        size.width * 0.8860893,
        size.height * 0.3718369);
    path_0.cubicTo(
        size.width * 0.8915595,
        size.height * 0.3647685,
        size.width * 0.8915595,
        size.height * 0.3647685,
        size.width * 0.8762083,
        size.height * 0.3716512);
    path_0.cubicTo(
        size.width * 0.8507679,
        size.height * 0.3831839,
        size.width * 0.8478214,
        size.height * 0.3796494,
        size.width * 0.8698988,
        size.height * 0.3642107);
    path_0.cubicTo(
        size.width * 0.8945000,
        size.height * 0.3470976,
        size.width * 0.9220476,
        size.height * 0.3121274,
        size.width * 0.9319286,
        size.height * 0.2855274);
    path_0.cubicTo(
        size.width * 0.9413929,
        size.height * 0.2607881,
        size.width * 0.9399167,
        size.height * 0.2604161,
        size.width * 0.9111131,
        size.height * 0.2801333);
    path_0.cubicTo(
        size.width * 0.8776786,
        size.height * 0.3030125,
        size.width * 0.8474048,
        size.height * 0.3178935,
        size.width * 0.8116607,
        size.height * 0.3286821);
    path_0.cubicTo(
        size.width * 0.7656131,
        size.height * 0.3424470,
        size.width * 0.7675060,
        size.height * 0.3398429,
        size.width * 0.8204881,
        size.height * 0.3167774);
    path_0.cubicTo(
        size.width * 0.8980774,
        size.height * 0.2831095,
        size.width * 0.9363452,
        size.height * 0.2433030,
        size.width * 0.9535833,
        size.height * 0.1783845);
    path_0.cubicTo(
        size.width * 0.9628393,
        size.height * 0.1437863,
        size.width * 0.9594762,
        size.height * 0.08314702,
        size.width * 0.9468571,
        size.height * 0.05412887);
    path_0.cubicTo(
        size.width * 0.9363452,
        size.height * 0.02976131,
        size.width * 0.9361369,
        size.height * 0.02976131,
        size.width * 0.9252024,
        size.height * 0.04110804);
    path_0.lineTo(size.width * 0.9172083, size.height * 0.04947857);
    path_0.lineTo(size.width * 0.9214167, size.height * 0.03906190);
    path_0.cubicTo(
        size.width * 0.9266726,
        size.height * 0.02585506,
        size.width * 0.9268810,
        size.height * 0.002975601,
        size.width * 0.9218393,
        size.height * 0.002975601);
    path_0.cubicTo(
        size.width * 0.9197321,
        size.height * 0.002975601,
        size.width * 0.9060655,
        size.height * 0.008369940,
        size.width * 0.8915595,
        size.height * 0.01506637);
    path_0.close();
    path_0.moveTo(size.width * 0.9006012, size.height * 0.1160708);
    path_0.cubicTo(
        size.width * 0.8875655,
        size.height * 0.1346720,
        size.width * 0.8629643,
        size.height * 0.1603417,
        size.width * 0.8459286,
        size.height * 0.1728042);
    path_0.cubicTo(
        size.width * 0.8373095,
        size.height * 0.1789429,
        size.width * 0.8438274,
        size.height * 0.1705720,
        size.width * 0.8619107,
        size.height * 0.1521571);
    path_0.cubicTo(
        size.width * 0.8785238,
        size.height * 0.1348577,
        size.width * 0.8955536,
        size.height * 0.1160708,
        size.width * 0.8993393,
        size.height * 0.1103042);
    path_0.cubicTo(
        size.width * 0.9031250,
        size.height * 0.1045381,
        size.width * 0.9071190,
        size.height * 0.1006321,
        size.width * 0.9079583,
        size.height * 0.1015619);
    path_0.cubicTo(
        size.width * 0.9090119,
        size.height * 0.1023060,
        size.width * 0.9056488,
        size.height * 0.1090024,
        size.width * 0.9006012,
        size.height * 0.1160708);
    path_0.close();
    path_0.moveTo(size.width * 0.9045952, size.height * 0.1863833);
    path_0.cubicTo(
        size.width * 0.9045952,
        size.height * 0.1869411,
        size.width * 0.8936607,
        size.height * 0.1966137,
        size.width * 0.8804167,
        size.height * 0.2077744);
    path_0.lineTo(size.width * 0.8562321, size.height * 0.2280500);
    path_0.lineTo(size.width * 0.8791548, size.height * 0.2066583);
    path_0.cubicTo(
        size.width * 0.9006012,
        size.height * 0.1867554,
        size.width * 0.9045952,
        size.height * 0.1835929,
        size.width * 0.9045952,
        size.height * 0.1863833);
    path_0.close();
    path_0.moveTo(size.width * 0.7363869, size.height * 0.4229905);
    path_0.cubicTo(
        size.width * 0.6861310,
        size.height * 0.4389875,
        size.width * 0.6728869,
        size.height * 0.4445679,
        size.width * 0.6375595,
        size.height * 0.4648429);
    path_0.lineTo(size.width * 0.6123274, size.height * 0.4795381);
    path_0.lineTo(size.width * 0.6333571, size.height * 0.4624250);
    path_0.cubicTo(
        size.width * 0.6581667,
        size.height * 0.4421494,
        size.width * 0.6949643,
        size.height * 0.4257804,
        size.width * 0.7372262,
        size.height * 0.4159220);
    path_0.cubicTo(
        size.width * 0.7849524,
        size.height * 0.4049470,
        size.width * 0.7847440,
        size.height * 0.4075512,
        size.width * 0.7363869,
        size.height * 0.4229905);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = color;
    canvas.drawPath(path_0, paint0Fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.02884815, size.height * 0.2265619);
    path_1.cubicTo(
        size.width * 0.009503988,
        size.height * 0.2364202,
        size.width * 0.02674554,
        size.height * 0.2522315,
        size.width * 0.05660292,
        size.height * 0.2522315);
    path_1.cubicTo(
        size.width * 0.09297857,
        size.height * 0.2522315,
        size.width * 0.1234667,
        size.height * 0.2751107,
        size.width * 0.1325077,
        size.height * 0.3091512);
    path_1.cubicTo(
        size.width * 0.1375542,
        size.height * 0.3283101,
        size.width * 0.1362929,
        size.height * 0.7650655,
        size.width * 0.1310363,
        size.height * 0.7981786);
    path_1.cubicTo(
        size.width * 0.1196821,
        size.height * 0.8703512,
        size.width * 0.08603988,
        size.height * 0.9069940,
        size.width * 0.03137131,
        size.height * 0.9069940);
    path_1.cubicTo(
        size.width * 0.01034500,
        size.height * 0.9069940,
        size.width * -0.002270780,
        size.height * 0.9179702,
        size.width * 0.005088435,
        size.height * 0.9298750);
    path_1.cubicTo(
        size.width * 0.01097583,
        size.height * 0.9399167,
        size.width * 0.3301554,
        size.height * 0.9406607,
        size.width * 0.3343607,
        size.height * 0.9306190);
    path_1.cubicTo(
        size.width * 0.3383560,
        size.height * 0.9216905,
        size.width * 0.3295244,
        size.height * 0.9148036,
        size.width * 0.3084982,
        size.height * 0.9101548);
    path_1.cubicTo(
        size.width * 0.2820054,
        size.height * 0.9042024,
        size.width * 0.2597173,
        size.height * 0.8842976,
        size.width * 0.2510964,
        size.height * 0.8588155);
    path_1.cubicTo(
        size.width * 0.2452089,
        size.height * 0.8415179,
        size.width * 0.2443679,
        size.height * 0.8126845,
        size.width * 0.2443679,
        size.height * 0.6523452);
    path_1.lineTo(size.width * 0.2443679, size.height * 0.4661452);
    path_1.lineTo(size.width * 0.2756970, size.height * 0.5305054);
    path_1.cubicTo(
        size.width * 0.2931488,
        size.height * 0.5660333,
        size.width * 0.3312065,
        size.height * 0.6417381,
        size.width * 0.3604333,
        size.height * 0.6988452);
    path_1.lineTo(size.width * 0.4138399, size.height * 0.8026429);
    path_1.lineTo(size.width * 0.4281381, size.height * 0.7916667);
    path_1.cubicTo(
        size.width * 0.4359179,
        size.height * 0.7855298,
        size.width * 0.4447488,
        size.height * 0.7805060,
        size.width * 0.4479030,
        size.height * 0.7805060);
    path_1.cubicTo(
        size.width * 0.4575750,
        size.height * 0.7805060,
        size.width * 0.4598875,
        size.height * 0.6953095,
        size.width * 0.4506363,
        size.height * 0.6856369);
    path_1.cubicTo(
        size.width * 0.4104762,
        size.height * 0.6439702,
        size.width * 0.3867161,
        size.height * 0.5571048,
        size.width * 0.3959679,
        size.height * 0.4869786);
    path_1.lineTo(size.width * 0.4005935, size.height * 0.4510780);
    path_1.lineTo(size.width * 0.3598024, size.height * 0.3675589);
    path_1.cubicTo(
        size.width * 0.3375149,
        size.height * 0.3214280,
        size.width * 0.3143857,
        size.height * 0.2738089,
        size.width * 0.3087083,
        size.height * 0.2615321);
    path_1.cubicTo(
        size.width * 0.2891542,
        size.height * 0.2198655,
        size.width * 0.2992464,
        size.height * 0.2224696,
        size.width * 0.1585804,
        size.height * 0.2226554);
    path_1.cubicTo(
        size.width * 0.08330655,
        size.height * 0.2226554,
        size.width * 0.03347399,
        size.height * 0.2241435,
        size.width * 0.02884815,
        size.height * 0.2265619);
    path_1.close();

    Paint paint1Fill = Paint()..style = PaintingStyle.fill;
    paint1Fill.color = color;
    canvas.drawPath(path_1, paint1Fill);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.4447488, size.height * 0.3991810);
    path_2.cubicTo(
        size.width * 0.4142607,
        size.height * 0.4471720,
        size.width * 0.4033274,
        size.height * 0.5241810,
        size.width * 0.4186762,
        size.height * 0.5846345);
    path_2.cubicTo(
        size.width * 0.4247738,
        size.height * 0.6093750,
        size.width * 0.4567339,
        size.height * 0.6757798,
        size.width * 0.4607292,
        size.height * 0.6722440);
    path_2.cubicTo(
        size.width * 0.4615702,
        size.height * 0.6713155,
        size.width * 0.4670369,
        size.height * 0.6540179,
        size.width * 0.4729244,
        size.height * 0.6335536);
    path_2.cubicTo(
        size.width * 0.4788113,
        size.height * 0.6130952,
        size.width * 0.4889042,
        size.height * 0.5827744,
        size.width * 0.4956327,
        size.height * 0.5660333);
    path_2.cubicTo(
        size.width * 0.5076179,
        size.height * 0.5360857,
        size.width * 0.5078280,
        size.height * 0.5355274,
        size.width * 0.5002583,
        size.height * 0.5232506);
    path_2.cubicTo(
        size.width * 0.4872220,
        size.height * 0.5016732,
        size.width * 0.4630417,
        size.height * 0.4319190,
        size.width * 0.4598881,
        size.height * 0.4056911);
    path_2.lineTo(size.width * 0.4567339, size.height * 0.3805798);
    path_2.lineTo(size.width * 0.4447488, size.height * 0.3991810);
    path_2.close();

    Paint paint2Fill = Paint()..style = PaintingStyle.fill;
    paint2Fill.color = color;
    canvas.drawPath(path_2, paint2Fill);

    Path path_3 = Path();
    path_3.moveTo(size.width * 0.5749018, size.height * 0.4542411);
    path_3.cubicTo(
        size.width * 0.5181310,
        size.height * 0.5437131,
        size.width * 0.4716625,
        size.height * 0.6821071,
        size.width * 0.4714524,
        size.height * 0.7609762);
    path_3.lineTo(size.width * 0.4714524, size.height * 0.7767857);
    path_3.lineTo(size.width * 0.4941607, size.height * 0.7767857);
    path_3.lineTo(size.width * 0.5166589, size.height * 0.7767857);
    path_3.lineTo(size.width * 0.5189720, size.height * 0.7088929);
    path_3.cubicTo(
        size.width * 0.5217054,
        size.height * 0.6203512,
        size.width * 0.5370542,
        size.height * 0.5595238,
        size.width * 0.5820506,
        size.height * 0.4559155);
    path_3.cubicTo(
        size.width * 0.5957202,
        size.height * 0.4246655,
        size.width * 0.5938256,
        size.height * 0.4241071,
        size.width * 0.5749018,
        size.height * 0.4542411);
    path_3.close();

    Paint paint3Fill = Paint()..style = PaintingStyle.fill;
    paint3Fill.color = color;
    canvas.drawPath(path_3, paint3Fill);

    Path path_4 = Path();
    path_4.moveTo(size.width * 0.8337381, size.height * 0.4827000);
    path_4.cubicTo(
        size.width * 0.8190179,
        size.height * 0.5009292,
        size.width * 0.7939940,
        size.height * 0.5293887,
        size.width * 0.7780179,
        size.height * 0.5457577);
    path_4.lineTo(size.width * 0.7490000, size.height * 0.5755196);
    path_4.lineTo(size.width * 0.7487917, size.height * 0.6919643);
    path_4.cubicTo(
        size.width * 0.7485774,
        size.height * 0.8733274,
        size.width * 0.7414286,
        size.height * 0.8967619,
        size.width * 0.6812976,
        size.height * 0.9107143);
    path_4.cubicTo(
        size.width * 0.6598512,
        size.height * 0.9157381,
        size.width * 0.6499643,
        size.height * 0.9242917,
        size.width * 0.6571131,
        size.height * 0.9317321);
    path_4.cubicTo(
        size.width * 0.6634226,
        size.height * 0.9386131,
        size.width * 0.9842857,
        size.height * 0.9391726,
        size.width * 0.9920655,
        size.height * 0.9322917);
    path_4.cubicTo(
        size.width * 1.005101,
        size.height * 0.9207560,
        size.width * 0.9910119,
        size.height * 0.9069940,
        size.width * 0.9664107,
        size.height * 0.9069940);
    path_4.cubicTo(
        size.width * 0.9260417,
        size.height * 0.9068095,
        size.width * 0.8905060,
        size.height * 0.8798333,
        size.width * 0.8745298,
        size.height * 0.8374226);
    path_4.cubicTo(
        size.width * 0.8652738,
        size.height * 0.8128690,
        size.width * 0.8648571,
        size.height * 0.8067321,
        size.width * 0.8627500,
        size.height * 0.6305774);
    path_4.lineTo(size.width * 0.8604405, size.height * 0.4492179);
    path_4.lineTo(size.width * 0.8337381, size.height * 0.4827000);
    path_4.close();

    Paint paint4Fill = Paint()..style = PaintingStyle.fill;
    paint4Fill.color = color;
    canvas.drawPath(path_4, paint4Fill);

    Path path_5 = Path();
    path_5.moveTo(size.width * 0.5742708, size.height * 0.7204226);
    path_5.cubicTo(
        size.width * 0.5494601,
        size.height * 0.7340000,
        size.width * 0.5227565,
        size.height * 0.7667381,
        size.width * 0.5296952,
        size.height * 0.7754821);
    path_5.cubicTo(
        size.width * 0.5402083,
        size.height * 0.7883155,
        size.width * 0.5551369,
        size.height * 0.7875714,
        size.width * 0.5599732,
        size.height * 0.7738095);
    path_5.cubicTo(
        size.width * 0.5629167,
        size.height * 0.7661845,
        size.width * 0.5704863,
        size.height * 0.7496250,
        size.width * 0.5767940,
        size.height * 0.7367917);
    path_5.cubicTo(
        size.width * 0.5833125,
        size.height * 0.7239583,
        size.width * 0.5883589,
        size.height * 0.7135417,
        size.width * 0.5879381,
        size.height * 0.7135417);
    path_5.cubicTo(
        size.width * 0.5875179,
        size.height * 0.7135417,
        size.width * 0.5812095,
        size.height * 0.7167024,
        size.width * 0.5742708,
        size.height * 0.7204226);
    path_5.close();

    Paint paint5Fill = Paint()..style = PaintingStyle.fill;
    paint5Fill.color = color;
    canvas.drawPath(path_5, paint5Fill);

    Path path_6 = Path();
    path_6.moveTo(size.width * 0.4756577, size.height * 0.7905476);
    path_6.cubicTo(
        size.width * 0.4474821,
        size.height * 0.7948274,
        size.width * 0.4378101,
        size.height * 0.7994762,
        size.width * 0.4378101,
        size.height * 0.8091488);
    path_6.cubicTo(
        size.width * 0.4378101,
        size.height * 0.8167798,
        size.width * 0.4390720,
        size.height * 0.8178929,
        size.width * 0.4451696,
        size.height * 0.8152917);
    path_6.cubicTo(
        size.width * 0.4491643,
        size.height * 0.8136131,
        size.width * 0.4706113,
        size.height * 0.8121250,
        size.width * 0.4924786,
        size.height * 0.8121250);
    path_6.cubicTo(
        size.width * 0.5145565,
        size.height * 0.8121250,
        size.width * 0.5357929,
        size.height * 0.8136131,
        size.width * 0.5397881,
        size.height * 0.8152917);
    path_6.cubicTo(
        size.width * 0.5458857,
        size.height * 0.8178929,
        size.width * 0.5471470,
        size.height * 0.8167798,
        size.width * 0.5471470,
        size.height * 0.8093393);
    path_6.cubicTo(
        size.width * 0.5471470,
        size.height * 0.7959464,
        size.width * 0.5080381,
        size.height * 0.7855298,
        size.width * 0.4756577,
        size.height * 0.7905476);
    path_6.close();

    Paint paint6Fill = Paint()..style = PaintingStyle.fill;
    paint6Fill.color = color;
    canvas.drawPath(path_6, paint6Fill);

    Path path_7 = Path();
    path_7.moveTo(size.width * 0.4670268, size.height * 0.8260357);
    path_7.cubicTo(
        size.width * 0.4581958,
        size.height * 0.8280833,
        size.width * 0.4558827,
        size.height * 0.8321726,
        size.width * 0.4512571,
        size.height * 0.8515179);
    path_7.cubicTo(
        size.width * 0.4485238,
        size.height * 0.8643571,
        size.width * 0.4430571,
        size.height * 0.8797917,
        size.width * 0.4394827,
        size.height * 0.8861190);
    path_7.cubicTo(
        size.width * 0.4329643,
        size.height * 0.8972798,
        size.width * 0.4329643,
        size.height * 0.8978393,
        size.width * 0.4455804,
        size.height * 0.9104881);
    path_7.cubicTo(
        size.width * 0.4609292,
        size.height * 0.9259226,
        size.width * 0.4714423,
        size.height * 0.9439702,
        size.width * 0.4815351,
        size.height * 0.9715000);
    path_7.cubicTo(
        size.width * 0.4893149,
        size.height * 0.9932619,
        size.width * 0.4962536,
        size.height * 1.003304,
        size.width * 0.4962536,
        size.height * 0.9928869);
    path_7.cubicTo(
        size.width * 0.4962536,
        size.height * 0.9796845,
        size.width * 0.5183310,
        size.height * 0.9348512,
        size.width * 0.5338905,
        size.height * 0.9168095);
    path_7.lineTo(size.width * 0.5502911, size.height * 0.8976488);
    path_7.lineTo(size.width * 0.5427214, size.height * 0.8796071);
    path_7.cubicTo(
        size.width * 0.5383060,
        size.height * 0.8697500,
        size.width * 0.5336804,
        size.height * 0.8539405,
        size.width * 0.5319982,
        size.height * 0.8444524);
    path_7.cubicTo(
        size.width * 0.5284238,
        size.height * 0.8234345,
        size.width * 0.5046643,
        size.height * 0.8167381,
        size.width * 0.4670268,
        size.height * 0.8260357);
    path_7.close();
    path_7.moveTo(size.width * 0.4996179, size.height * 0.8928155);
    path_7.cubicTo(
        size.width * 0.5006690,
        size.height * 0.8987679,
        size.width * 0.4989869,
        size.height * 0.9008155,
        size.width * 0.4922583,
        size.height * 0.9008155);
    path_7.cubicTo(
        size.width * 0.4867917,
        size.height * 0.9008155,
        size.width * 0.4836375,
        size.height * 0.8983929,
        size.width * 0.4836375,
        size.height * 0.8939286);
    path_7.cubicTo(
        size.width * 0.4836375,
        size.height * 0.8797917,
        size.width * 0.4973048,
        size.height * 0.8788631,
        size.width * 0.4996179,
        size.height * 0.8928155);
    path_7.close();

    Paint paint7Fill = Paint()..style = PaintingStyle.fill;
    paint7Fill.color = color;
    canvas.drawPath(path_7, paint7Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
