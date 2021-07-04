class Maiyam {
  final int id;
  final String nextEvent, title, description, image, quote;

  Maiyam({this.id, this.nextEvent, this.title, this.description, this.image, this.quote});
}

// list of products
// for our demo
List<Maiyam> maiyams = [
  Maiyam(
    id: 1,
    nextEvent: "12 Nov 2020",
    title: "Shakti Maiyam",
    quote: "Shakti illayel Shivam illai!",
    image: "assets/images/shakti.png",
    description:
    "The entire society grows when women are empowered. "
        "Shakti maiyam encourages spiritual, religious, cultural and scientific growth "
        "of women folk with various free trainings and camps.",
  ),
  Maiyam(
    id: 2,
    nextEvent: "12 Nov 2020",
    title: "Saraswati Maiyam",
    quote: "Knowlege is power!",
    image: "assets/images/saraswati.png",
    description:
    "Saraswati Maiyam helps in education of poor children with free tuitions, academic counselling, "
        "vocational training, entrance exam preparation among others, by qualified teachers.",
  ),
  Maiyam(
    id: 3,
    nextEvent: "25 Feb 2020",
    title: "Dhanvantari Maiyam",
    quote: "Health is wealth!",
    image: "assets/images/dhanvantari.png",
    description:
    "Physical health is first and foremost. "
        "Dhanvantari Maiyam conducts free medical camps, Paati Vaithiyam "
        "and lifestyle changes, all to increase awareness on "
        "our traditional healthy way of living.",
  ),
  Maiyam(
    id: 4,
    nextEvent: "13 Jun 2020",
    title: "Prabhanja Maiyam",
    quote: "Neer, Nilam, Neruppu, Katru, Aagayam",
    image: "assets/images/prabhanjam.png",
    description:
    "Everything we see around us is a form of God. "
        "Prabhanja maiyam encourages environment friendly lifestyle and conducts "
        "camps and awareness sessions to that effect.",
  ),
  Maiyam(
    id: 5,
    nextEvent: "N/A",
    title: "Mano Maiyam",
    quote: "Where there is a will there is a way!",
    image: "assets/images/mano.png",
    description:
    "Mano Maiyam insists on mental and spiritual health. It provides refreshing spiritual discourses, "
        "Yoga and Pranayama classes, group medidation among others.",
  ),
];
