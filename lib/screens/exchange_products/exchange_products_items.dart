class exchangeProduct {
  String? exchangeProductId;
  String? name;
  String? image;

  int? points;
  int quantity = 0;

  exchangeProduct(
    this.name,
    this.image,
    this.exchangeProductId,
    this.points,
    this.quantity,
  );
}

List<exchangeProduct> cleanProducts = [
  exchangeProduct(
    'Vanish Gold',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkPFN35dT2rG-uCCsXoV1D7Q_RDPcBx1_MHw&usqp=CAU',
    '1',
    200,
    0,
  ),
  exchangeProduct(
    'Tide',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSsV09IUxfUNUrwzoosDDFw-UDHOWJoe_FRdVWO65pM0XHBqR44clVU5rg3dUbRm1j-lXA&usqp=CAU',
    '2',
    100,
    0,
  ),
  exchangeProduct(
    'Airiel',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRpWM5FaJy1_EQaqZ4SH-lNDMngd_eQ2OxWhtFJP6W40xQEtpgZnMy8JlFJoS2-yLKoD4c&usqp=CAU',
    '3',
    200,
    0,
  ),
  exchangeProduct(
    'Persil',
    'https://pngimage.net/wp-content/uploads/2018/06/persil-png-5.png',
    '4',
    100,
    0,
  ),
  exchangeProduct(
    'Omo',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTnuTM45dROakE43zoGWCbbwjP8fm_VVD7euA&usqp=CAU',
    '5',
    200,
    0,
  ),
];

List<exchangeProduct> houseWareProducts = [
  exchangeProduct(
    'broom',
    'https://z.nooncdn.com/products/tr:n-t_240/v1616871137/N27388242A_1.jpg',
    '1',
    200,
    0,
  ),
  exchangeProduct(
    'Cleaning Brush',
    'https://www.bigbasket.com/media/uploads/p/xxl/228455_6-gala-plastic-brush.jpg',
    '2',
    100,
    0,
  ),
  exchangeProduct(
    'shovel',
    'https://sc04.alicdn.com/kf/UTB87n0aBWrFXKJk43Ovq6ybnpXag.jpg',
    '3',
    200,
    0,
  ),
  exchangeProduct(
    'wiper',
    'https://4.imimg.com/data4/WU/PN/MY-23182445/angle-wiper-250x250.png',
    '4',
    200,
    0,
  ),
  exchangeProduct(
    'water collector',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJXu_ZEmR3DzBS3oJrTT_DVXEuBuSk9enWtw&usqp=CAU',
    '5',
    300,
    0,
  ),
  exchangeProduct(
    'broom head',
    'https://cf3.s3.souqcdn.com/item/2019/12/23/99/46/88/35/item_XL_99468835_6c904dcc9cbc2.jpg',
    '6',
    50,
    0,
  ),
];
