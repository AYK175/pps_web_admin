/*
class _VetProfileDetailsState extends State<VetProfileDetails> {
  late Map data;
  double wallet = 0.0;
  String walletString = '';

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('vet_wallet')
        .doc(widget.VetID)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        setState(() {
          wallet = snapshot.data()!['wallet'];
          walletString = wallet.toStringAsFixed(2); // Format as a string with 2 decimal places

        });
      } else {
        print('Document does not exist on the database');
      }
    }).catchError((error) => print('Error retrieving wallet: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Vet Profile',
                style: TextStyle(color: ColorManager.orangeColor, fontSize: 20),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            margin: const EdgeInsets.symmetric(vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                FutureBuilder<DocumentSnapshot>(
                  future: widget._futureData,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Some error occurred. ${snapshot.error}'));
                    }

                    if (snapshot.hasData) {
                      //Get the data
                      DocumentSnapshot documentSnapshot = snapshot.data;
                      data = documentSnapshot.data() as Map;
                      DateTime expiryDate = DateTime.fromMillisecondsSinceEpoch(data['LicenseExpiryDate'].seconds * 1000);
                      String formattedExpiryDate = DateFormat('dd-MM-yyyy').format(expiryDate);

                      DateTime issueDate = DateTime.fromMillisecondsSinceEpoch(data['LicenseIssueDate'].seconds * 1000);
                      String formattedIssueDate = DateFormat('dd-MM-yyyy').format(issueDate);

                      //display the data
                      return SingleChildScrollView(
                        child: Container(
                          width: double.infinity,
                          child: SafeArea(
                            bottom: false,
                            child: Column(
                              children: [


                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: kBackgroundColor,
                                    borderRadius:
                                    BorderRadius.vertical(top: Radius.circular(50),bottom:  Radius.circular(50)),
                                  ),
                                  child: Padding(
                                      padding: EdgeInsets.all(25),
                                      child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,

                                          children: [
                                            Text(
                                              "Wallet Balance: "+walletString,
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                  color: kTitleTextColor),
                                            ),

                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  height: 3,
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),

                                                Center(
                                                  child: Text(
                                                    "${data['ProfileStatus']}".toUpperCase(), // Profile Status At top
                                                    style: TextStyle(
                                                        fontSize: 30,
                                                        fontWeight: FontWeight.bold,
                                                        color: kTitleTextColor),
                                                  ),
                                                ),

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
//Button
                                                Container(
                                                  width: 150.0,
                                                  height: 45.0,
                                                  decoration: BoxDecoration(
                                                    color: ColorManager.darkColor,
                                                    shape: BoxShape.rectangle,
                                                    borderRadius: BorderRadius.circular(20.0),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      // Check the current status of the profile
                                                      if (data['ProfileStatus'] == 'UnApproved') {
                                                        // Update the profile status to 'Approved'
                                                        FirebaseFirestore.instance.collection('vets').doc(widget.VetID).update({
                                                          'ProfileStatus': 'Approved',
                                                          'ProfileUnapprovalReason': 'Approved',
                                                        }).then((value) {
                                                          // Update the state of the widget with the new value of ProfileStatus
                                                          setState(() {
                                                            data['ProfileStatus'] = 'Approved';
                                                            data['ProfileUnapprovalReason'] = 'Approved';

                                                          });
                                                        });
                                                      } else {
                                                        // Update the profile status to 'UnApproved'
                                                        FirebaseFirestore.instance.collection('vets').doc(widget.VetID).update({
                                                          'ProfileStatus': 'UnApproved',
                                                          'ProfileUnapprovalReason': 'Suspended',

                                                        }).then((value) {
                                                          // Update the state of the widget with the new value of ProfileStatus
                                                          setState(() {
                                                            data['ProfileStatus'] = 'UnApproved';
                                                            data['ProfileUnapprovalReason'] = 'Suspended';


                                                          });
                                                        });
                                                      }
                                                    },
                                                    child: Center(
                                                      child: Text(
                                                        (data['ProfileStatus'] == 'UnApproved') ? 'Approve Profile' : 'Unapprove Profile',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 50,
                                                ),

                                              ],
                                            ),

                                          ]
                                      )

                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );


                    }

                    return Center(child: CircularProgressIndicator());
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
*/
