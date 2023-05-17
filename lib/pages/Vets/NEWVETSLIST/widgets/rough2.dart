/*
Row(
children: [
Image(image: NetworkImage("${data['profileImg']}"),
height: 120,

),
SizedBox(
width: 15,
),
Expanded(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
"${data['name']}",
style: TextStyle(
fontSize: 24,
fontWeight: FontWeight.bold,
color: kTitleTextColor),
),
SizedBox(
height: 3,
),
Text(
"${data['specialization']}",
style: TextStyle(
fontSize: 15,
fontWeight: FontWeight.bold,

color: kTitleTextColor.withOpacity(0.7)),
overflow: TextOverflow.ellipsis,maxLines: 2,
),
SizedBox(
height: 2,
),
Text(
"${data['qualification']}",
style: TextStyle(
fontSize: 15,
fontWeight: FontWeight.bold,

color: kTitleTextColor.withOpacity(0.7)),
overflow: TextOverflow.ellipsis,maxLines: 2,

),
Text(
"Experience: ${data['year']}",
style: TextStyle(
fontSize: 15,
fontWeight: FontWeight.bold,

color: kTitleTextColor.withOpacity(0.7)),
overflow: TextOverflow.ellipsis,maxLines: 2,

),

SizedBox(
height: 10,
),

],
),
)
],
),
SizedBox(
height: 50,
),
SizedBox(
height: 5,
),
Column(
crossAxisAlignment: CrossAxisAlignment.center,

children: [
Text(
'PERSONAL INFORMATION:',
style: TextStyle(
color: kTitleTextColor,
fontSize: 25,
fontWeight: FontWeight.bold),
),

Text(
'Email: ${data['email']}',
style: TextStyle(
fontSize: 15,
fontWeight: FontWeight.w600,
height: 1.7,
color: kTitleTextColor.withOpacity(0.8)),
),
Text(
'Phone Number: ${data['phone number']}',
style: TextStyle(
fontSize: 15,
fontWeight: FontWeight.w600,
height: 1.7,
color: kTitleTextColor.withOpacity(0.8)),
),
Text(
'CNIC: ${data['cnic']}',
style: TextStyle(
fontSize: 15,
fontWeight: FontWeight.w600,
height: 1.7,
color: kTitleTextColor.withOpacity(0.8)),
),
Text(
'PVMC Licence No: ${data['VetLiceance']}',
style: TextStyle(
fontSize: 15,
fontWeight: FontWeight.w600,
height: 1.7,
color: kTitleTextColor.withOpacity(0.8)),
),
Text(
'PVMC Issue Expiry: $formattedIssueDate',
style: TextStyle(
fontSize: 15,
fontWeight: FontWeight.w600,
height: 1.7,
color: kTitleTextColor.withOpacity(0.8)),
),

SizedBox(
height: 10,
),
Card(
elevation: 2.0,
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(16.0),
),
child: Container(
height: 300,
width: 600,
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(16.0),
color: Colors.white,
image: DecorationImage(
fit: BoxFit.fitHeight,
image: NetworkImage(
"${data['licenseImageLink']}"
),
),
),
),
),
SizedBox(
height: 5,
),
*/
/*   GestureDetector(
                                      onTap: () => launch('https://pvmc.gov.pk/Registration/Search', forceSafariVC: true),
                                      child: Text(
                                        'Verify',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          height: 1.7,
                                          color: kTitleTextColor.withOpacity(0.8),
                                        ),
                                      ),
                                    ),
*//*

SizedBox(
height: 10,
),

Text(
'About Doctor:',
style: TextStyle(

color: kTitleTextColor,
fontSize: 25,
fontWeight: FontWeight.bold),
),
SizedBox(
height: 5,
),
Text(
'${data['description']}',
textAlign: TextAlign.justify,


style: TextStyle(
fontWeight: FontWeight.w600,

height: 1.6,
color: kTitleTextColor.withOpacity(0.8)),
),
],
),
SizedBox(
height: 50,
),
//Button*/
