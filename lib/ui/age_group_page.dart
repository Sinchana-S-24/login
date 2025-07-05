import 'package:flutter/material.dart';

class AgeGroupPage extends StatefulWidget {
  @override
  _AgeGroupPageState createState() => _AgeGroupPageState();
}

class _AgeGroupPageState extends State<AgeGroupPage>
    with TickerProviderStateMixin {
  String? selectedGroup;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List<Map<String, dynamic>> ageGroups = [
    {
      'range': '18-20',
      'label': 'Young Adult',
      'icon': Icons.school,
      'color': Colors.green,
      'description': 'College & Early Career'
    },
    {
      'range': '21-25',
      'label': 'Early Professional',
      'icon': Icons.work_outline,
      'color': Colors.blue,
      'description': 'Career Building'
    },
    {
      'range': '26-30',
      'label': 'Young Professional',
      'icon': Icons.trending_up,
      'color': Colors.purple,
      'description': 'Growth & Development'
    },
    {
      'range': '31-35',
      'label': 'Established Professional',
      'icon': Icons.business_center,
      'color': Colors.orange,
      'description': 'Leadership & Expertise'
    },
    {
      'range': '36-40',
      'label': 'Senior Professional',
      'icon': Icons.supervised_user_circle,
      'color': Colors.red,
      'description': 'Mentoring & Strategy'
    },
    {
      'range': '41+',
      'label': 'Experienced Professional',
      'icon': Icons.star,
      'color': Colors.indigo,
      'description': 'Wisdom & Excellence'
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _submitAgeGroup() {
    if (selectedGroup != null) {
      // Show success dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 28),
                SizedBox(width: 12),
                Text('Success!'),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('You have successfully selected:'),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue[200]!),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        ageGroups.firstWhere(
                            (group) => group['range'] == selectedGroup)['icon'],
                        color: Colors.blue[600],
                      ),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Age Group: $selectedGroup',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            ageGroups.firstWhere((group) =>
                                group['range'] == selectedGroup)['label'],
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Continue'),
              ),
            ],
          );
        },
      );
    }
  }

  Widget _buildAgeGroupCard(Map<String, dynamic> group, int index) {
    final isSelected = selectedGroup == group['range'];

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: Offset(0, 0.5),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: _animationController,
            curve: Interval(
              index * 0.1,
              (index * 0.1) + 0.6,
              curve: Curves.easeOutCubic,
            ),
          )),
          child: FadeTransition(
            opacity: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(CurvedAnimation(
              parent: _animationController,
              curve: Interval(
                index * 0.1,
                (index * 0.1) + 0.6,
                curve: Curves.easeInOut,
              ),
            )),
            child: child,
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        child: Material(
          elevation: isSelected ? 8 : 2,
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              setState(() {
                selectedGroup = group['range'];
              });
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? group['color'] : Colors.grey[300]!,
                  width: isSelected ? 2 : 1,
                ),
                color:
                    isSelected ? group['color'].withOpacity(0.1) : Colors.white,
              ),
              child: Row(
                children: [
                  // Icon
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: isSelected ? group['color'] : Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      group['icon'],
                      color: isSelected ? Colors.white : Colors.grey[600],
                      size: 24,
                    ),
                  ),
                  SizedBox(width: 16),
                  // Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          group['range'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color:
                                isSelected ? group['color'] : Colors.grey[800],
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          group['label'],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color:
                                isSelected ? group['color'] : Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          group['description'],
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Radio indicator
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? group['color'] : Colors.grey[400]!,
                        width: 2,
                      ),
                      color: isSelected ? group['color'] : Colors.transparent,
                    ),
                    child: isSelected
                        ? Icon(
                            Icons.check,
                            size: 16,
                            color: Colors.white,
                          )
                        : null,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.grey[800]),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Age Group Selection',
          style: TextStyle(
            color: Colors.grey[800],
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 16),
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Step 2 of 3',
                  style: TextStyle(
                    color: Colors.blue[600],
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Column(
            children: [
              // Header Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(24),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.blue[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.person_outline,
                            color: Colors.blue[600],
                            size: 24,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Select Your Age Group',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[800],
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Help us personalize your experience',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Age Groups List
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(24),
                  itemCount: ageGroups.length,
                  itemBuilder: (context, index) {
                    return _buildAgeGroupCard(ageGroups[index], index);
                  },
                ),
              ),

              // Bottom Section with Submit Button
              Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: Offset(0, -5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (selectedGroup != null)
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        margin: EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.green[200]!),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.check_circle, color: Colors.green[600]),
                            SizedBox(width: 12),
                            Text(
                              'Selected: $selectedGroup',
                              style: TextStyle(
                                color: Colors.green[800],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed:
                            selectedGroup == null ? null : _submitAgeGroup,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[600],
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: selectedGroup == null ? 0 : 3,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Continue',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward, size: 20),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'You can change this later in your profile settings',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
