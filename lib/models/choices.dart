import 'package:kovilmaiyam/repository/data_repository.dart';
import 'package:smart_select/smart_select.dart' show S2Choice;
import 'kovil_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'kovil.dart';

KovilTest k1 = new KovilTest(9, 'Chennai', 'Vadiyudaiyamman',
    '01-Thiruvotriyur', '001', '01', 'Sundareshwarar Kovil', 'Om Nama Shivaya', 'KOVIL0100101',
    new ContactDetails('12/14, Shivan Kovil St\nNanganallur\nChennai 600041',
        '9940036215'), [new Admin('Venkat',
        new ContactDetails('Nanganallur', '9884359169'), true)]);

KovilTest k2 = new KovilTest(2, 'Chennai', 'Vadiyudaiyamman',
    '01-Thiruvotriyur', '001', '01', 'Vinayagar Kovil', 'Muzhu Muthal Kadavule', 'KOVIL0100201',
    new ContactDetails('12/14, Shivan Kovil St\nNanganallur\nChennai 600041',
        '9940036215'), [new Admin('Venkat',
        new ContactDetails('Nanganallur', '9884359169'), true)]);

KovilTest k3 = new KovilTest(3, 'Chennai', 'Vadiyudaiyamman',
    '02-Tambaram', '001', '01', 'Ramar Kovil', 'Jai Shri Ram', 'KOVIL0200101',
    new ContactDetails('12/14, Shivan Kovil St\nNanganallur\nChennai 600041',
        '9940036215'), [new Admin('Venkat',
        new ContactDetails('Nanganallur', '9884359169'), true)]);

KovilTest k4 = new KovilTest(4, 'Chennai', 'Vadiyudaiyamman',
    '02-Tambaram', '001', '02', 'Pillayar Kovil', 'En Arumai Pillayar', 'KOVIL0200102',
    new ContactDetails('12/14, Shivan Kovil St\nTambaram\nChennai 600041',
        '9940036215'), [new Admin('Venkat',
        new ContactDetails('Nanganallur', '9884359169'), true)]);

KovilTest k5 = new KovilTest(5, 'Chennai', 'Vadiyudaiyamman',
    '02-Tambaram', '001', '03', 'Amman Kovil', 'Amma Magamaye', 'KOVIL0200103',
    new ContactDetails('12/14, Shivan Kovil St\nTambaram\nChennai 600041',
        '9940036215'), [new Admin('Venkat',
        new ContactDetails('Nanganallur', '9884359169'), true)]);

KovilTest k6 = new KovilTest(6, 'Chennai', 'Kodiyidaiamman',
    '01-Redhills', '001', '01', 'Muthu maariamman Kovil', 'Maariamma', 'KOVIL0100101',
    new ContactDetails('12/14, Shivan Kovil St\nTambaram\nChennai 600041',
        '9940036215'), [new Admin('Venkat',
        new ContactDetails('Nanganallur', '9884359169'), true)]);

KovilTest k7 = new KovilTest(7, 'Chennai', 'Kodiyidaiamman',
    '01-Redhills', '005', '01', 'Kaliamman Kovil', 'Kaaliamma', 'KOVIL0100501',
    new ContactDetails('12/14, Shivan Kovil St\nTambaram\nChennai 600041',
        '9940036215'), [new Admin('Venkat',
        new ContactDetails('Nanganallur', '9884359169'), true)]);

KovilTest k8 = new KovilTest(8, 'Chennai', 'Raveeshwarar',
    '09-Mambalam', '001', '01', 'Krishna Temple ISKCON', 'Jai Shri Krishna', 'KOVIL0900101',
    new ContactDetails('12/14, Shivan Kovil St\nTambaram\nChennai 600041',
        '9940036215'), [new Admin('Venkat',
        new ContactDetails('Nanganallur', '9884359169'), true)]);

KovilTest k9 = new KovilTest(9, 'Chennai', 'Raveeshwarar',
    '09-Mambalam', '001', '02', 'Murugan Temple', 'Vetrivel Thunai', 'KOVIL0900102',
    new ContactDetails('12/14, Shivan Kovil St\nTambaram\nChennai 600041',
        '9940036215'), [new Admin('Venkat',
        new ContactDetails('Nanganallur', '9884359169'), true)]);

List<KovilTest> listOfKovils = [k1, k2, k3, k4, k5, k6, k7, k8, k9];
//KovilTestContainer kovilsContainer = new KovilTestContainer(listOfKovils);

//KovilRepository repository = new KovilRepository();
//KovilContainer kovilContainer;

/*
void loadKovils() async {
  List<Kovil> kovilCollection = await repository.getKovilStream();
  kovilContainer = new KovilContainer(kovilCollection);
}
*/

List<S2Choice<String>> days = [
  S2Choice<String>(value: 'mon', title: 'Monday'),
  S2Choice<String>(value: 'tue', title: 'Tuesday'),
  S2Choice<String>(value: 'wed', title: 'Wednesday'),
  S2Choice<String>(value: 'thu', title: 'Thursday'),
  S2Choice<String>(value: 'fri', title: 'Friday'),
  S2Choice<String>(value: 'sat', title: 'Saturday'),
  S2Choice<String>(value: 'sun', title: 'Sunday'),
];

List<S2Choice<String>> months = [
  S2Choice<String>(value: 'jan', title: 'January'),
  S2Choice<String>(value: 'feb', title: 'February'),
  S2Choice<String>(value: 'mar', title: 'March'),
  S2Choice<String>(value: 'apr', title: 'April'),
  S2Choice<String>(value: 'may', title: 'May'),
  S2Choice<String>(value: 'jun', title: 'June'),
  S2Choice<String>(value: 'jul', title: 'July'),
  S2Choice<String>(value: 'aug', title: 'August'),
  S2Choice<String>(value: 'sep', title: 'September'),
  S2Choice<String>(value: 'oct', title: 'October'),
  S2Choice<String>(value: 'nov', title: 'November'),
  S2Choice<String>(value: 'dec', title: 'December'),
];

List<S2Choice<String>> os = [
  S2Choice<String>(value: 'and', title: 'Android'),
  S2Choice<String>(value: 'ios', title: 'IOS'),
  S2Choice<String>(value: 'mac', title: 'Macintos'),
  S2Choice<String>(value: 'tux', title: 'Linux'),
  S2Choice<String>(value: 'win', title: 'Windows'),
];

List<S2Choice<String>> dhanvantari_activity_type = [
  S2Choice<String>(value: 'lifestyle', title: 'Lifestyle Training'),
  S2Choice<String>(value: 'paati', title: 'Paati Vaithiyam Training'),
  S2Choice<String>(value: 'camp', title: 'Medical Camp'),
];

List<S2Choice<String>> dhanvantari_medical_camp_type = [
  S2Choice<String>(value: 'siddha', title: 'Siddha'),
  S2Choice<String>(value: 'ayurveda', title: 'Ayurveda'),
  S2Choice<String>(value: 'allopathy', title: 'Allopathy'),
];

List<S2Choice<String>> mano_activity_type = [
  S2Choice<String>(value: 'satsangam', title: 'Satsangam'),
  S2Choice<String>(value: 'pranayamam', title: 'Pranayamam'),
  S2Choice<String>(value: 'meditation', title: 'Meditation'),
  S2Choice<String>(value: 'yoga', title: 'Yoga'),
  S2Choice<String>(value: 'other', title: 'Other'),
];

List<S2Choice<String>> prabanja_activity_type = [
  S2Choice<String>(value: 'neer', title: 'Neer'),
  S2Choice<String>(value: 'nilam', title: 'Nilam'),
  S2Choice<String>(value: 'neruppu', title: 'Neruppu'),
  S2Choice<String>(value: 'Katru', title: 'Katru'),
  S2Choice<String>(value: 'aagayam', title: 'Aagayam'),
  S2Choice<String>(value: 'other', title: 'Other'),
];

List<S2Choice<String>> shakthi_activity_type = [
  S2Choice<String>(value: 'newyear', title: 'Tamil New Year'),
  S2Choice<String>(value: 'akshaya', title: 'Akshaya Trithiyai'),
  S2Choice<String>(value: 'krishna', title: 'Krishna Jayanthi'),
  S2Choice<String>(value: 'navarathri', title: 'Navarathri'),
  S2Choice<String>(value: 'kannan', title: 'Kannan Nam Thozhan'),
  S2Choice<String>(value: 'shivarathri', title: 'Shivarathri'),
  S2Choice<String>(value: 'other', title: 'Other'),
];

List<S2Choice<String>> gender_type = [
  S2Choice<String>(value: 'male', title: 'Male'),
  S2Choice<String>(value: 'female', title: 'Female'),
  S2Choice<String>(value: 'other', title: 'Other'),
];

List<S2Choice<String>> tamilmonth_type = [
  S2Choice<String>(value: 'chitthirai', title: 'Chitthirai'),
  S2Choice<String>(value: 'vaikasi', title: 'Vaikasi'),
  S2Choice<String>(value: 'aani', title: 'Aani'),
  S2Choice<String>(value: 'aadi', title: 'Aadi'),
  S2Choice<String>(value: 'aavani', title: 'Aavani'),
  S2Choice<String>(value: 'purattasi', title: 'Purattasi'),
  S2Choice<String>(value: 'aipassi', title: 'Aipassi'),
  S2Choice<String>(value: 'karthikai', title: 'Karthikai'),
  S2Choice<String>(value: 'margazhi', title: 'Margazhi'),
  S2Choice<String>(value: 'thai', title: 'Thai'),
  S2Choice<String>(value: 'maasi', title: 'Maasi'),
  S2Choice<String>(value: 'panguni', title: 'Panguni'),
];

List<S2Choice<String>> nakshatra_type = [
  S2Choice<String>(value: 'aswini', title: 'Aswini'),
  S2Choice<String>(value: 'bharani', title: 'Bharani'),
  S2Choice<String>(value: 'karthigai', title: 'Karthigai'),
  S2Choice<String>(value: 'rohini', title: 'Rohini'),
  S2Choice<String>(value: 'mrigasheersham', title: 'Mrigasheersham'),
  S2Choice<String>(value: 'thiruvaathirai', title: 'Thiruvaathirai'),
  S2Choice<String>(value: 'punarpoosam', title: 'Punarpoosam'),
  S2Choice<String>(value: 'poosam', title: 'Poosam'),
  S2Choice<String>(value: 'aayilyam', title: 'Aayilyam'),
  S2Choice<String>(value: 'makam', title: 'Makam'),
  S2Choice<String>(value: 'pooram', title: 'Pooram'),
  S2Choice<String>(value: 'uthiram', title: 'Uthiram'),
  S2Choice<String>(value: 'hastham', title: 'Hastham'),
  S2Choice<String>(value: 'chithirai', title: 'Chithirai'),
  S2Choice<String>(value: 'swathi', title: 'Swathi'),
  S2Choice<String>(value: 'visaakam', title: 'Visaakam'),
  S2Choice<String>(value: 'anusham', title: 'Anusham'),
  S2Choice<String>(value: 'kettai', title: 'Kettai'),
  S2Choice<String>(value: 'moolam', title: 'Moolam'),
  S2Choice<String>(value: 'pooraadam', title: 'Pooraadam'),
  S2Choice<String>(value: 'uthiraadam', title: 'Uthiraadam'),
  S2Choice<String>(value: 'thiruvonam', title: 'Thiruvonam'),
  S2Choice<String>(value: 'avittam', title: 'Avittam'),
  S2Choice<String>(value: 'sadayam', title: 'Sadayam'),
  S2Choice<String>(value: 'poorattathi', title: 'Poorattathi'),
  S2Choice<String>(value: 'uthirattadhi', title: 'Uthirattadhi'),
  S2Choice<String>(value: 'revathi', title: 'Revathi'),
];

List<S2Choice<String>> heroes = [
  S2Choice<String>(value: 'bat', title: 'Batman'),
  S2Choice<String>(value: 'sup', title: 'Superman'),
  S2Choice<String>(value: 'hul', title: 'Hulk'),
  S2Choice<String>(value: 'spi', title: 'Spiderman'),
  S2Choice<String>(value: 'iro', title: 'Ironman'),
  S2Choice<String>(value: 'won', title: 'Wonder Woman'),
];

List<S2Choice<String>> fruits = [
  S2Choice<String>(value: 'app', title: 'Apple'),
  S2Choice<String>(value: 'ore', title: 'Orange'),
  S2Choice<String>(value: 'mel', title: 'Melon'),
];

List<S2Choice<String>> frameworks = [
  S2Choice<String>(value: 'ion', title: 'Ionic'),
  S2Choice<String>(value: 'flu', title: 'Flutter'),
  S2Choice<String>(value: 'rea', title: 'React Native'),
];

List<S2Choice<String>> categories = [
  S2Choice<String>(value: 'ele', title: 'Electronics'),
  S2Choice<String>(value: 'aud', title: 'Audio & Video'),
  S2Choice<String>(value: 'acc', title: 'Accessories'),
  S2Choice<String>(value: 'ind', title: 'Industrial'),
  S2Choice<String>(value: 'wat', title: 'Smartwatch'),
  S2Choice<String>(value: 'sci', title: 'Scientific'),
  S2Choice<String>(value: 'mea', title: 'Measurement'),
  S2Choice<String>(value: 'pho', title: 'Smartphone'),
];

List<S2Choice<String>> sorts = [
  S2Choice<String>(value: 'popular', title: 'Popular'),
  S2Choice<String>(value: 'review', title: 'Most Reviews'),
  S2Choice<String>(value: 'latest', title: 'Newest'),
  S2Choice<String>(value: 'cheaper', title: 'Low Price'),
  S2Choice<String>(value: 'pricey', title: 'High Price'),
];

List<Map<String,dynamic>> cars = [
  { 'value': 'bmw-x1', 'title': 'BMW X1', 'brand': 'BMW', 'body': 'SUV' },
  { 'value': 'bmw-x7', 'title': 'BMW X7', 'brand': 'BMW', 'body': 'SUV' },
  { 'value': 'bmw-x2', 'title': 'BMW X2', 'brand': 'BMW', 'body': 'SUV' },
  { 'value': 'bmw-x4', 'title': 'BMW X4', 'brand': 'BMW', 'body': 'SUV' },
  { 'value': 'honda-crv', 'title': 'Honda C-RV', 'brand': 'Honda', 'body': 'SUV' },
  { 'value': 'honda-hrv', 'title': 'Honda H-RV', 'brand': 'Honda', 'body': 'SUV' },
  { 'value': 'mercedes-gcl', 'title': 'Mercedes-Benz G-class', 'brand': 'Mercedes', 'body': 'SUV' },
  { 'value': 'mercedes-gle', 'title': 'Mercedes-Benz GLE', 'brand': 'Mercedes', 'body': 'SUV' },
  { 'value': 'mercedes-ecq', 'title': 'Mercedes-Benz ECQ', 'brand': 'Mercedes', 'body': 'SUV' },
  { 'value': 'mercedes-glcc', 'title': 'Mercedes-Benz GLC Coupe', 'brand': 'Mercedes', 'body': 'SUV' },
  { 'value': 'lr-ds', 'title': 'Land Rover Discovery Sport', 'brand': 'Land Rover', 'body': 'SUV' },
  { 'value': 'lr-rre', 'title': 'Land Rover Range Rover Evoque', 'brand': 'Land Rover', 'body': 'SUV' },
  { 'value': 'honda-jazz', 'title': 'Honda Jazz', 'brand': 'Honda', 'body': 'Hatchback' },
  { 'value': 'honda-civic', 'title': 'Honda Civic', 'brand': 'Honda', 'body': 'Hatchback' },
  { 'value': 'mercedes-ac', 'title': 'Mercedes-Benz A-class', 'brand': 'Mercedes', 'body': 'Hatchback' },
  { 'value': 'hyundai-i30f', 'title': 'Hyundai i30 Fastback', 'brand': 'Hyundai', 'body': 'Hatchback' },
  { 'value': 'hyundai-kona', 'title': 'Hyundai Kona Electric', 'brand': 'Hyundai', 'body': 'Hatchback' },
  { 'value': 'hyundai-i10', 'title': 'Hyundai i10', 'brand': 'Hyundai', 'body': 'Hatchback' },
  { 'value': 'bmw-i3', 'title': 'BMW i3', 'brand': 'BMW', 'body': 'Hatchback' },
  { 'value': 'bmw-sgc', 'title': 'BMW 4-serie Gran Coupe', 'brand': 'BMW', 'body': 'Hatchback' },
  { 'value': 'bmw-sgt', 'title': 'BMW 6-serie GT', 'brand': 'BMW', 'body': 'Hatchback' },
  { 'value': 'audi-a5s', 'title': 'Audi A5 Sportback', 'brand': 'Audi', 'body': 'Hatchback' },
  { 'value': 'audi-rs3s', 'title': 'Audi RS3 Sportback', 'brand': 'Audi', 'body': 'Hatchback' },
  { 'value': 'audi-ttc', 'title': 'Audi TT Coupe', 'brand': 'Audi', 'body': 'Coupe' },
  { 'value': 'audi-r8c', 'title': 'Audi R8 Coupe', 'brand': 'Audi', 'body': 'Coupe' },
  { 'value': 'mclaren-570gt', 'title': 'Mclaren 570GT', 'brand': 'Mclaren', 'body': 'Coupe' },
  { 'value': 'mclaren-570s', 'title': 'Mclaren 570S Spider', 'brand': 'Mclaren', 'body': 'Coupe' },
  { 'value': 'mclaren-720s', 'title': 'Mclaren 720S', 'brand': 'Mclaren', 'body': 'Coupe' },
];

List<Map<String,dynamic>> smartphones = [
  { 'id': 'sk3', 'name': 'Samsung Keystone 3', 'brand': 'Samsung', 'category': 'Budget Phone' },
  { 'id': 'n106', 'name': 'Nokia 106', 'brand': 'Nokia', 'category': 'Budget Phone' },
  { 'id': 'n150', 'name': 'Nokia 150', 'brand': 'Nokia', 'category': 'Budget Phone' },
  { 'id': 'r7a', 'name': 'Redmi 7A', 'brand': 'Xiaomi', 'category': 'Mid End Phone' },
  { 'id': 'ga10s', 'name': 'Galaxy A10s', 'brand': 'Samsung', 'category': 'Mid End Phone' },
  { 'id': 'rn7', 'name': 'Redmi Note 7', 'brand': 'Xiaomi', 'category': 'Mid End Phone' },
  { 'id': 'ga20s', 'name': 'Galaxy A20s', 'brand': 'Samsung', 'category': 'Mid End Phone' },
  { 'id': 'mc9', 'name': 'Meizu C9', 'brand': 'Meizu', 'category': 'Mid End Phone' },
  { 'id': 'm6', 'name': 'Meizu M6', 'brand': 'Meizu', 'category': 'Mid End Phone' },
  { 'id': 'ga2c', 'name': 'Galaxy A2 Core', 'brand': 'Samsung', 'category': 'Mid End Phone' },
  { 'id': 'r6a', 'name': 'Redmi 6A', 'brand': 'Xiaomi', 'category': 'Mid End Phone' },
  { 'id': 'r5p', 'name': 'Redmi 5 Plus', 'brand': 'Xiaomi', 'category': 'Mid End Phone' },
  { 'id': 'ga70', 'name': 'Galaxy A70', 'brand': 'Samsung', 'category': 'Mid End Phone' },
  { 'id': 'ai11', 'name': 'iPhone 11 Pro', 'brand': 'Apple', 'category': 'Flagship Phone' },
  { 'id': 'aixr', 'name': 'iPhone XR', 'brand': 'Apple', 'category': 'Flagship Phone' },
  { 'id': 'aixs', 'name': 'iPhone XS', 'brand': 'Apple', 'category': 'Flagship Phone' },
  { 'id': 'aixsm', 'name': 'iPhone XS Max', 'brand': 'Apple', 'category': 'Flagship Phone' },
  { 'id': 'hp30', 'name': 'Huawei P30 Pro', 'brand': 'Huawei', 'category': 'Flagship Phone' },
  { 'id': 'ofx', 'name': 'Oppo Find X', 'brand': 'Oppo', 'category': 'Flagship Phone' },
  { 'id': 'gs10', 'name': 'Galaxy S10+', 'brand': 'Samsung', 'category': 'Flagship Phone' },
];

List<Map<String,dynamic>> transports = [
  {
    'title': 'Plane',
    'image': 'https://source.unsplash.com/Eu1xLlWuTWY/100x100',
  },
  {
    'title': 'Train',
    'image': 'https://source.unsplash.com/Njq3Nz6-5rQ/100x100',
  },
  {
    'title': 'Bus',
    'image': 'https://source.unsplash.com/qoXgaF27zBc/100x100',
  },
  {
    'title': 'Car',
    'image': 'https://source.unsplash.com/p7tai9P7H-s/100x100',
  },
  {
    'title': 'Bike',
    'image': 'https://source.unsplash.com/2LTMNCN4nEg/100x100',
  },
];