// import 'package:flutter/material.dart';
// import 'claude_service.dart';
// import 'theme/app_colors.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   String? _newsContent;
//   bool _isLoading = false;
//   String _selectedCountry = 'Global';
//   String _selectedLanguage = 'Kurdish';
//   String _selectedTopic = 'Breaking News';
//   String _errorMessage = '';

//   final List<String> _countries = [
//     'Iraq',
//     'Syria',
//     'Kurdistan Region',
//     'Iran',
//     'Turkey',
//     'Germany',
//     'Sweden',
//     'United States',
//     'All Europe',
//     'Global'
//   ];

//   final List<String> _languages = ['English', 'Arabic', 'Kurdish'];

//   final List<String> _topics = [
//     'Breaking News',
//     'World',
//     'Politics',
//     'Business',
//     'Economy',
//     'Sports',
//     'Technology',
//     'Science',
//     'Health',
//     'Entertainment',
//     'Culture',
//     'Arts',
//     'Local',
//     'Education',
//     'Lifestyle',
//     'Environment',
//     'Climate',
//     'Human Interest',
//     'Gaming',
//     'Social Media',
//     'Startups',
//     'Automotive',
//     'Security',
//     'Defense',
//   ];

//   void refresh() {
//     setState(() {
//       _newsContent = null;
//       _isLoading = false;
//       _selectedCountry = 'Global';
//       _selectedLanguage = 'Kurdish';
//       _selectedTopic = 'Breaking News';
//       _errorMessage = '';
//     });
//   }

//   Future<void> _fetchNews() async {
//     if (_isLoading) return;

//     setState(() {
//       _isLoading = true;
//       _newsContent = null;
//       _errorMessage = '';
//     });

//     try {
//       print('Starting news fetch...');
//       final content = await ClaudeService().getNews(
//         country: _selectedCountry,
//         language: _selectedLanguage,
//         topic: _selectedTopic,
//       );

//       setState(() {
//         _newsContent = content;
//         _isLoading = false;
//       });

//       print('News fetch completed successfully');
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//         _errorMessage = e.toString();
//       });

//       // Show error snackbar
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Error: ${e.toString()}'),
//             backgroundColor: Colors.red,
//             duration: const Duration(seconds: 5),
//           ),
//         );
//       }
//     }
//   }

//   bool get _isRTLlanguage {
//     return _selectedLanguage == 'Arabic' || _selectedLanguage == 'Kurdish';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text(
//           'AI News Assistant',
//           style: TextStyle(
//             fontWeight: FontWeight.w600,
//             color: Colors.white,
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: AppColors.primaryColor,
//         elevation: 0,
//         actions: [
//           IconButton(
//             tooltip: 'Refresh',
//             icon: const Icon(Icons.refresh, color: Colors.white),
//             onPressed: refresh,
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             children: [
//               // Country Selection Card
//               _buildSelectionCard(
//                 icon: Icons.public,
//                 title: 'Select Country',
//                 value: _selectedCountry,
//                 items: _countries,
//                 onChanged: (value) {
//                   if (value != null) {
//                     setState(() {
//                       _selectedCountry = value;
//                     });
//                   }
//                 },
//               ),

//               const SizedBox(height: 16),

//               // Language Selection Card
//               _buildSelectionCard(
//                 icon: Icons.language,
//                 title: 'Select Language',
//                 value: _selectedLanguage,
//                 items: _languages,
//                 onChanged: (value) {
//                   if (value != null) {
//                     setState(() {
//                       _selectedLanguage = value;
//                     });
//                   }
//                 },
//               ),

//               const SizedBox(height: 16),

//               // Topic Selection Card
//               _buildSelectionCard(
//                 icon: Icons.category,
//                 title: 'Select Topic',
//                 value: _selectedTopic,
//                 items: _topics,
//                 onChanged: (value) {
//                   if (value != null) {
//                     setState(() {
//                       _selectedTopic = value;
//                     });
//                   }
//                 },
//               ),

//               const SizedBox(height: 24),

//               // Get News Button
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: _isLoading ? null : _fetchNews,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.primaryColor,
//                     foregroundColor: Colors.white,
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     elevation: 2,
//                   ),
//                   child: _isLoading
//                       ? const SizedBox(
//                           width: 20,
//                           height: 20,
//                           child: CircularProgressIndicator(
//                             strokeWidth: 2,
//                             valueColor: AlwaysStoppedAnimation(Colors.white),
//                           ),
//                         )
//                       : const Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(Icons.newspaper, size: 20),
//                             SizedBox(width: 8),
//                             Text(
//                               'Get AI News',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ],
//                         ),
//                 ),
//               ),

//               const SizedBox(height: 28),

//               // Loading Indicator
//               if (_isLoading)
//                 Column(
//                   children: [
//                     SizedBox(
//                       width: 50,
//                       height: 50,
//                       child: CircularProgressIndicator(
//                         valueColor:
//                             AlwaysStoppedAnimation(AppColors.primaryColor),
//                         strokeWidth: 3,
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     Text(
//                       'Fetching AI news...',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.grey[700],
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       'Country: $_selectedCountry • Language: $_selectedLanguage • Topic: $_selectedTopic',
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.grey[600],
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     if (_selectedLanguage != 'English')
//                       Padding(
//                         padding: const EdgeInsets.only(top: 8.0),
//                         child: Text(
//                           'AI analyzing in English for quality, will translate to $_selectedLanguage',
//                           style: TextStyle(
//                             fontSize: 10,
//                             color: Colors.grey[500],
//                             fontStyle: FontStyle.italic,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                   ],
//                 ),

//               // Error Message
//               if (_errorMessage.isNotEmpty)
//                 Card(
//                   color: Colors.red[50],
//                   elevation: 2,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     side: BorderSide(color: Colors.red[200]!),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       children: [
//                         Row(
//                           children: [
//                             Icon(Icons.error, color: Colors.red[700]),
//                             const SizedBox(width: 8),
//                             Text(
//                               'Error',
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w600,
//                                 color: Colors.red[700],
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 8),
//                         Text(
//                           _errorMessage,
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Colors.red[600],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//               // News Content Section
//               if (_newsContent != null && !_isLoading)
//                 Card(
//                   elevation: 4,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(24.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               children: [
//                                 Icon(Icons.newspaper,
//                                     color: AppColors.primaryColor),
//                                 const SizedBox(width: 8),
//                                 Text(
//                                   'AI News Analysis',
//                                   style: TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.w600,
//                                     color: AppColors.primaryColor,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 12, vertical: 6),
//                               decoration: BoxDecoration(
//                                 color:
//                                     AppColors.primaryColor.withOpacity(0.1),
//                                 borderRadius: BorderRadius.circular(20),
//                               ),
//                               child: Column(
//                                 children: [
//                                   Text(
//                                     _selectedCountry,
//                                     style: TextStyle(
//                                       fontSize: 11,
//                                       color: AppColors.primaryColor,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                   Text(
//                                     '${_selectedTopic} • ${_selectedLanguage}',
//                                     style: TextStyle(
//                                       fontSize: 10,
//                                       color: AppColors.primaryColor
//                                           .withOpacity(0.8),
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 16),
//                         Container(
//                           width: double.infinity,
//                           padding: const EdgeInsets.all(16),
//                           decoration: BoxDecoration(
//                             color: Colors.grey[50],
//                             borderRadius: BorderRadius.circular(12),
//                             border: Border.all(
//                               color: Colors.grey[200]!,
//                               width: 1,
//                             ),
//                           ),
//                           child: Directionality(
//                             textDirection: _isRTLlanguage
//                                 ? TextDirection.rtl
//                                 : TextDirection.ltr,
//                             child: SelectableText(
//                               _newsContent!,
//                               style: TextStyle(
//                                 fontSize: 15,
//                                 color: Colors.grey[800],
//                                 height: 1.5,
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             Icon(
//                               Icons.lightbulb_outline,
//                               size: 14,
//                               color: Colors.grey[500],
//                             ),
//                             const SizedBox(width: 4),
//                             Text(
//                               'Powered by Claude AI',
//                               style: TextStyle(
//                                 fontSize: 11,
//                                 color: Colors.grey[500],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//               // Empty State
//               if (_newsContent == null && !_isLoading && _errorMessage.isEmpty)
//                 Padding(
//                   padding: const EdgeInsets.only(top: 40),
//                   child: Column(
//                     children: [
//                       Icon(
//                         Icons.newspaper_outlined,
//                         size: 64,
//                         color: Colors.grey[300],
//                       ),
//                       const SizedBox(height: 16),
//                       Text(
//                         'Select country, language, and topic',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.grey[700],
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         'to get AI-powered news from Claude',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.grey[600],
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                       const SizedBox(height: 24),
//                       Container(
//                         padding: const EdgeInsets.all(16),
//                         decoration: BoxDecoration(
//                           color: Colors.grey[50],
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Column(
//                           children: [
//                             _buildInfoRow(
//                               'Current Selection:',
//                               '$_selectedCountry • $_selectedLanguage • $_selectedTopic',
//                             ),
//                             const SizedBox(height: 8),
//                             _buildInfoRow(
//                               'AI Process:',
//                               'Analyzes in English → Translates to $_selectedLanguage',
//                             ),
//                             const SizedBox(height: 8),
//                             _buildInfoRow(
//                               'Quality Focus:',
//                               'English-first for best news coverage',
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//               const SizedBox(height: 40),
//               Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: AppColors.primaryColor.withOpacity(0.05),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Column(
//                   children: [
//                     Text(
//                       'AI News Assistant',
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                         color: AppColors.primaryColor,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       'Country + Language + Topic AI News System',
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.grey[600],
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       'Developed by Zinar Mizury',
//                       style: TextStyle(
//                         fontSize: 11,
//                         color: Colors.grey[500],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSelectionCard({
//     required IconData icon,
//     required String title,
//     required String value,
//     required List<String> items,
//     required Function(String?) onChanged,
//   }) {
//     return Card(
//       color: Colors.white,
//       elevation: 3,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Icon(icon, color: AppColors.primaryColor),
//                 const SizedBox(width: 8),
//                 Text(
//                   title,
//                   style: TextStyle(
//                     fontSize: 12,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.grey[800],
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 12),
//             DropdownButtonFormField<String>(
//               value: value,
//               isExpanded: true,
//               decoration: InputDecoration(
//                 contentPadding:
//                     const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: BorderSide(color: AppColors.neutralColor),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: BorderSide(color: AppColors.neutralColor),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: BorderSide(color: AppColors.primaryColor),
//                 ),
//               ),
//               items: items
//                   .map((item) => DropdownMenuItem(
//                         value: item,
//                         child: Text(
//                           item,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ))
//                   .toList(),
//               onChanged: onChanged,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoRow(String label, String value) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 12,
//             fontWeight: FontWeight.w600,
//             color: Colors.grey[700],
//           ),
//         ),
//         const SizedBox(width: 8),
//         Expanded(
//           child: Text(
//             value,
//             style: TextStyle(
//               fontSize: 12,
//               color: Colors.grey[600],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'claude_service.dart';
import 'theme/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _newsContent;
  bool _isLoading = false;
  String _selectedCountry = 'Global';
  String _selectedLanguage = 'Kurdish';
  String _selectedTopic = 'Breaking News';
  String _errorMessage = '';

  final List<String> _countries = [
    'Iraq',
    'Syria',
    'Kurdistan Region',
    'Iran',
    'Turkey',
    'Germany',
    'Sweden',
    'United States',
    'All Europe',
    'Global'
  ];

  final List<String> _languages = ['English', 'Arabic', 'Kurdish'];

  final List<String> _topics = [
    'Breaking News',
    'World',
    'Politics',
    'Business',
    'Economy',
    'Sports',
    'Technology',
    'Science',
    'Health',
    'Entertainment',
    'Culture',
    'Arts',
    'Local',
    'Education',
    'Lifestyle',
    'Environment',
    'Climate',
    'Human Interest',
    'Gaming',
    'Social Media',
    'Startups',
    'Automotive',
    'Security',
    'Defense',
  ];

  void refresh() {
    setState(() {
      _newsContent = null;
      _isLoading = false;
      _selectedCountry = 'Global';
      _selectedLanguage = 'Kurdish';
      _selectedTopic = 'Breaking News';
      _errorMessage = '';
    });
  }

  Future<void> _fetchNews() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _newsContent = null;
      _errorMessage = '';
    });

    try {
      print('Starting news fetch...');
      final content = await ClaudeService().getNews(
        country: _selectedCountry,
        language: _selectedLanguage,
        topic: _selectedTopic,
      );

      setState(() {
        _newsContent = content;
        _isLoading = false;
      });

      print('News fetch completed successfully');
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString();
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    }
  }

  bool get _isRTLlanguage {
    return _selectedLanguage == 'Arabic' || _selectedLanguage == 'Kurdish';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A192F), // Dark blue background
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: 140.0,
            floating: false,
            pinned: true,
            backgroundColor: Color(0xFF0A192F),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'AI News Assistant',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontSize: 20,
                  shadows: [
                    Shadow(
                      blurRadius: 4.0,
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ],
                ),
              ),
              centerTitle: true,
              // background: Container(
              //   decoration: BoxDecoration(
              //     gradient: LinearGradient(
              //       begin: Alignment.topLeft,
              //       end: Alignment.bottomRight,
              //       colors: [
              //         Color(0xFF0A192F),
              //         Color(0xFF112240),
              //       ],
              //     ),
              //   ),
              //   child: Stack(
              //     children: [
              //       Positioned(
              //         top: 20,
              //         right: 20,
              //         child: Icon(
              //           Icons.public,
              //           size: 40,
              //           color: Colors.white.withOpacity(0.1),
              //         ),
              //       ),
              //       Positioned(
              //         bottom: 20,
              //         left: 20,
              //         child: Icon(
              //           Icons.newspaper,
              //           size: 40,
              //           color: Colors.white.withOpacity(0.1),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ),
            actions: [
              IconButton(
                onPressed: refresh,
                icon: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.refresh,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),

          // Main Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Welcome Card
                  // Container(
                  //   width: double.infinity,
                  //   padding: EdgeInsets.all(24),
                  //   decoration: BoxDecoration(
                  //     gradient: LinearGradient(
                  //       begin: Alignment.topLeft,
                  //       end: Alignment.bottomRight,
                  //       colors: [
                  //         Color(0xFF112240),
                  //         Color(0xFF1E3A8A),
                  //       ],
                  //     ),
                  //     borderRadius: BorderRadius.circular(20),
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: Colors.blue.withOpacity(0.2),
                  //         blurRadius: 20,
                  //         spreadRadius: 2,
                  //       ),
                  //     ],
                  //   ),
                  //   // child: Column(
                  //   //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   //   children: [
                  //   //     Row(
                  //   //       children: [
                  //   //         Container(
                  //   //           padding: EdgeInsets.all(8),
                  //   //           decoration: BoxDecoration(
                  //   //             color: Colors.white.withOpacity(0.1),
                  //   //             borderRadius: BorderRadius.circular(12),
                  //   //           ),
                  //   //           child: Icon(
                  //   //             Icons.lightbulb_outline,
                  //   //             color: Colors.white,
                  //   //             size: 24,
                  //   //           ),
                  //   //         ),
                  //   //         SizedBox(width: 12),
                  //   //         Expanded(
                  //   //           child: Column(
                  //   //             crossAxisAlignment: CrossAxisAlignment.start,
                  //   //             children: [
                  //   //               Text(
                  //   //                 'Smart News Discovery',
                  //   //                 style: TextStyle(
                  //   //                   fontSize: 18,
                  //   //                   fontWeight: FontWeight.w700,
                  //   //                   color: Colors.white,
                  //   //                 ),
                  //   //               ),
                  //   //               SizedBox(height: 4),
                  //   //               Text(
                  //   //                 'Select your preferences and get AI-generated news',
                  //   //                 style: TextStyle(
                  //   //                   fontSize: 14,
                  //   //                   color: Colors.white.withOpacity(0.8),
                  //   //                 ),
                  //   //               ),
                  //   //             ],
                  //   //           ),
                  //   //         ),
                  //   //       ],
                  //   //     ),
                  //   //     SizedBox(height: 16),
                  //   //     Wrap(
                  //   //       spacing: 8,
                  //   //       runSpacing: 8,
                  //   //       children: [
                  //   //         _buildChip('Country: $_selectedCountry'),
                  //   //         _buildChip('Language: $_selectedLanguage'),
                  //   //         _buildChip('Topic: $_selectedTopic'),
                  //   //       ],
                  //   //     ),
                  //   //   ],
                  //   // ),
                  // ),

                  SizedBox(height: 24),

                  // Dropdown Section
                  Container(
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Color(0xFF112240),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.tune,
                              color: Colors.white.withOpacity(0.7),
                            ),
                            SizedBox(width: 8),
                            Text(
                              'News Preferences',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),

                        // Three dropdowns in a row
                        Row(
                          children: [
                            Expanded(
                              child: _buildModernDropdown(
                                icon: Icons.public,
                                label: 'Country',
                                value: _selectedCountry,
                                items: _countries,
                                onChanged: (value) {
                                  if (value != null) {
                                    setState(() {
                                      _selectedCountry = value;
                                    });
                                  }
                                },
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: _buildModernDropdown(
                                icon: Icons.language,
                                label: 'Language',
                                value: _selectedLanguage,
                                items: _languages,
                                onChanged: (value) {
                                  if (value != null) {
                                    setState(() {
                                      _selectedLanguage = value;
                                    });
                                  }
                                },
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: _buildModernDropdown(
                                icon: Icons.category,
                                label: 'Topic',
                                value: _selectedTopic,
                                items: _topics,
                                onChanged: (value) {
                                  if (value != null) {
                                    setState(() {
                                      _selectedTopic = value;
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24),

                  // Action Button
                  Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF3B82F6),
                          Color(0xFF1D4ED8),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF3B82F6).withOpacity(0.3),
                          blurRadius: 15,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _fetchNews,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 24),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (_isLoading)
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              ),
                            )
                          else
                            Icon(
                              Icons.bolt,
                              color: Colors.white,
                              size: 22,
                            ),
                          SizedBox(width: _isLoading ? 12 : 8),
                          Text(
                            _isLoading ? 'Generating News...' : 'Get News',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 24),

                  // Loading Indicator
                  if (_isLoading)
                    Container(
                      padding: EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Color(0xFF112240),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            width: 60,
                            height: 60,
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation(Color(0xFF3B82F6)),
                              strokeWidth: 4,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'AI is analyzing news sources...',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Fetching latest $_selectedTopic news for $_selectedCountry',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.7),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 16),
                          LinearProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation(Color(0xFF3B82F6)),
                            backgroundColor: Colors.white.withOpacity(0.1),
                            minHeight: 4,
                          ),
                        ],
                      ),
                    ),

                  // Error Message
                  if (_errorMessage.isNotEmpty)
                    Container(
                      margin: EdgeInsets.only(bottom: 24),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Color(0xFFFEF2F2),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Color(0xFFFCA5A5)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Color(0xFFFECACA),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Icons.error_outline,
                              color: Color(0xFFDC2626),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Connection Issue',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFFDC2626),
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  _errorMessage,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF991B1B),
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () => setState(() => _errorMessage = ''),
                            icon: Icon(Icons.close, color: Color(0xFFDC2626)),
                          ),
                        ],
                      ),
                    ),

                  // News Content
                  if (_newsContent != null && !_isLoading)
                    Container(
                      padding: EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Color(0xFF112240),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFF3B82F6),
                                          Color(0xFF1D4ED8),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Icon(
                                      Icons.article,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'News Report',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      _selectedCountry,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      '${_selectedTopic} • ${_selectedLanguage}',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white.withOpacity(0.7),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 24),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.1),
                              ),
                            ),
                            child: Directionality(
                              textDirection: _isRTLlanguage
                                  ? TextDirection.rtl
                                  : TextDirection.ltr,
                              child: SelectableText(
                                _newsContent!,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white.withOpacity(0.9),
                                  height: 1.7,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.translate,
                                      size: 12,
                                      color: Colors.white.withOpacity(0.6),
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      _isRTLlanguage
                                          ? 'RTL Layout'
                                          : 'LTR Layout',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.white.withOpacity(0.6),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              TextButton.icon(
                                onPressed: _fetchNews,
                                style: TextButton.styleFrom(
                                  foregroundColor: Color(0xFF3B82F6),
                                ),
                                icon: Icon(Icons.refresh, size: 16),
                                label: Text(
                                  'Generate New Report',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                  // Empty State
                  if (_newsContent == null &&
                      !_isLoading &&
                      _errorMessage.isEmpty)
                    Container(
                      padding: EdgeInsets.all(40),
                      decoration: BoxDecoration(
                        color: Color(0xFF112240),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF3B82F6).withOpacity(0.2),
                                    Color(0xFF1D4ED8).withOpacity(0.2),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Icon(
                                Icons.newspaper,
                                size: 40,
                                color: Color(0xFF3B82F6),
                              ),
                            ),
                            SizedBox(height: 24),
                            Text(
                              'Ready to Discover News',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 12),
                            Text(
                              'Select your preferences and click "Get News" to get started',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white.withOpacity(0.7),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 24),
                            Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: [
                                _buildFeatureChip(
                                  icon: Icons.public,
                                  text: '10+ Countries',
                                ),
                                _buildFeatureChip(
                                  icon: Icons.language,
                                  text: '3 Languages',
                                ),
                                _buildFeatureChip(
                                  icon: Icons.category,
                                  text: '24 Topics',
                                ),
                                _buildFeatureChip(
                                  icon: Icons.bolt,
                                  text: 'AI-Powered',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                  SizedBox(height: 40),

                  // Footer
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        // SizedBox(height: 16),
                        // Divider(color: Colors.white.withOpacity(0.1)),
                        // SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.code,
                              size: 14,
                              color: Colors.white.withOpacity(0.5),
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Developed by Zinar Mizury',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernDropdown({
    required IconData icon,
    required String label,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: Colors.white.withOpacity(0.6)),
            SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              dropdownColor: Color(0xFF1E3A8A),
              icon: Icon(
                Icons.arrow_drop_down,
                color: Colors.white.withOpacity(0.6),
              ),
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      item,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChip(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle,
              size: 12, color: Colors.white.withOpacity(0.7)),
          SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureChip({required IconData icon, required String text}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Color(0xFF3B82F6)),
          SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}
