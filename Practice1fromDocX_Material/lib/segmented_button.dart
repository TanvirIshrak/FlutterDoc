import 'package:flutter/material.dart';
class SegmentedButtonOfApp extends StatefulWidget {
  const SegmentedButtonOfApp({super.key});

  @override
  State<SegmentedButtonOfApp> createState() => _SegmentedButtonOfAppState();
}

class _SegmentedButtonOfAppState extends State<SegmentedButtonOfApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text("Segmented Buttons"),),

        body: Center(
          child: Column(
            mainAxisAlignment: .center,
            children: [
              Text("Sengle choice", style: TextStyle(fontSize: 30),),
              SizedBox(height: 10,),
              const SingleChoice(),

              Text("Multiple choice", style: TextStyle(fontSize: 30),),
              SizedBox(height: 10,),
              const MultipleChoice(),

            ],
          ),
        ),
      ),
    );
  }
}

// Single choice
// calendar options
enum Calendar {day, week, month, year}

class SingleChoice extends StatefulWidget {
  const SingleChoice({super.key});

  @override
  State<SingleChoice> createState() => _SingleChoiceState();
}

class _SingleChoiceState extends State<SingleChoice> {

  // initially, week selected
  Calendar selectedCalendar = Calendar.month;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<Calendar>(
      segments: [
        ButtonSegment<Calendar>(
          value: Calendar.day,
          label: Text("Day"),
          icon: Icon(Icons.calendar_view_day)
        ),
        ButtonSegment<Calendar>(
            value: Calendar.week,
            label: Text("Week"),
            icon: Icon(Icons.calendar_view_week)
        ),
        ButtonSegment<Calendar>(
            value: Calendar.month,
            label: Text("Month"),
            icon: Icon(Icons.calendar_view_month)
        ),
        ButtonSegment<Calendar>(
            value: Calendar.year,
            label: Text("year"),
            icon: Icon(Icons.calendar_today)
        ),
      ],

      // initial selection
      selected: <Calendar>{ selectedCalendar },

      // this is user selection part
      // without this option the part would be faded and unchanged
      onSelectionChanged: (Set<Calendar> newSelected){
        setState(() {
          selectedCalendar = newSelected.first;

        });

        if(selectedCalendar == Calendar.day){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text("Day Selected"),
                behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 2),
            )
          );
        }
      },

      //after selection effect inside SegmentedButton
      style: SegmentedButton.styleFrom(
        selectedBackgroundColor: Colors.lightGreen,
        selectedForegroundColor: Colors.white
      ),
    );
  }
}


// possible sizes
enum Sizes {extraSmall, small, medium, large, extraLarge}

class MultipleChoice extends StatefulWidget {
  const MultipleChoice({super.key});

  @override
  State<MultipleChoice> createState() => _MultipleChoiceState();
}

class _MultipleChoiceState extends State<MultipleChoice> {

  // Initially l and xl are selected to show it's multicoisable
  Set<Sizes> selectedSizes = {
    Sizes.large, Sizes.extraLarge
  };

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<Sizes>(
      segments: [
        ButtonSegment<Sizes>(
          value: Sizes.extraSmall,
          label: Text("XS")
        ),
        ButtonSegment<Sizes>(
            value: Sizes.small,
            label: Text("S")
        ),
        ButtonSegment<Sizes>(
            value: Sizes.medium,
            label: Text("M")
        ),
        ButtonSegment<Sizes>(
            value: Sizes.large,
            label: Text("L")
        ),ButtonSegment<Sizes>(
            value: Sizes.extraLarge,
            label: Text("XL")
        ),

      ],
      // initial selection
      selected: selectedSizes,

      // Tow most important part of multiple selection segment
      // without multipleSelectionEnabled and onSelectionChanged error will occure
      // make sure these two are there before run
      // these two parts differentiate between singleChoice and MultiChoice
      multiSelectionEnabled: true,
      onSelectionChanged: (Set<Sizes> newSelection){
        setState(() {
          selectedSizes = newSelection;
        });
      },

      //after selection effect inside SegmentedButton
      style: SegmentedButton.styleFrom(
          selectedBackgroundColor: Colors.lightGreen,
          selectedForegroundColor: Colors.white
      ),
    );
  }
}

