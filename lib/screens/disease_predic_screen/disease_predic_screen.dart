import 'package:e_health/components/CustomStackBar.dart';
import 'package:e_health/resources/api_methods.dart';
import 'package:e_health/screens/disease_predic_screen/components/symptom_card.dart';
import 'package:e_health/utils/colors.dart';
import 'package:e_health/utils/styles.dart';
import 'package:flutter/material.dart';

class DiseasePredicScreen extends StatefulWidget {
  const DiseasePredicScreen({super.key});

  @override
  State<DiseasePredicScreen> createState() => _DiseasePredicScreenState();
}

class _DiseasePredicScreenState extends State<DiseasePredicScreen> {
  bool isLoading = false;
  String? predicDisease;
  List<String> selectedSymptoms = [];
  List<String> symptoms = [
    'itching',
    'skin_rash',
    'nodal_skin_eruptions',
    'continuous_sneezing',
    'shivering',
    'chills',
    'joint_pain',
    'stomach_pain',
    'acidity',
    'ulcers_on_tongue',
    'muscle_wasting',
    'vomiting',
    'burning_micturition',
    'spotting_ urination',
    'fatigue',
    'weight_gain',
    'anxiety',
    'cold_hands_and_feets',
    'mood_swings',
    'weight_loss',
    'restlessness',
    'lethargy',
    'patches_in_throat',
    'irregular_sugar_level',
    'cough',
    'high_fever',
    'sunken_eyes',
    'breathlessness',
    'sweating',
    'dehydration',
    'indigestion',
    'headache',
    'yellowish_skin',
    'dark_urine',
    'nausea',
    'loss_of_appetite',
    'pain_behind_the_eyes',
    'back_pain',
    'constipation',
    'abdominal_pain',
    'diarrhoea',
    'mild_fever',
    'yellow_urine',
    'yellowing_of_eyes',
    'acute_liver_failure',
    'fluid_overload',
    'swelling_of_stomach',
    'swelled_lymph_nodes',
    'malaise',
    'blurred_and_distorted_vision',
    'phlegm',
    'throat_irritation',
    'redness_of_eyes',
    'sinus_pressure',
    'runny_nose',
    'congestion',
    'chest_pain',
    'weakness_in_limbs',
    'fast_heart_rate',
    'pain_during_bowel_movements',
    'pain_in_anal_region',
    'bloody_stool',
    'irritation_in_anus',
    'neck_pain',
    'dizziness',
    'cramps',
    'bruising',
    'obesity',
    'swollen_legs',
    'swollen_blood_vessels',
    'puffy_face_and_eyes',
    'enlarged_thyroid',
    'brittle_nails',
    'swollen_extremeties',
    'excessive_hunger',
    'extra_marital_contacts',
    'drying_and_tingling_lips',
    'slurred_speech',
    'knee_pain',
    'hip_joint_pain',
    'muscle_weakness',
    'stiff_neck',
    'swelling_joints',
    'movement_stiffness',
    'spinning_movements',
    'loss_of_balance',
    'unsteadiness',
    'weakness_of_one_body_side',
    'loss_of_smell',
    'bladder_discomfort',
    'foul_smell_of urine',
    'continuous_feel_of_urine',
    'passage_of_gases',
    'internal_itching',
    'toxic_look_(typhos)',
    'depression',
    'irritability',
    'muscle_pain',
    'altered_sensorium',
    'red_spots_over_body',
    'belly_pain',
    'abnormal_menstruation',
    'dischromic _patches',
    'watering_from_eyes',
    'increased_appetite',
    'polyuria',
    'family_history',
    'mucoid_sputum',
    'rusty_sputum',
    'lack_of_concentration',
    'visual_disturbances',
    'receiving_blood_transfusion',
    'receiving_unsterile_injections',
    'coma',
    'stomach_bleeding',
    'distention_of_abdomen',
    'history_of_alcohol_consumption',
    'fluid_overload.1',
    'blood_in_sputum',
    'prominent_veins_on_calf',
    'palpitations',
    'painful_walking',
    'pus_filled_pimples',
    'blackheads',
    'scurring',
    'skin_peeling',
    'silver_like_dusting',
    'small_dents_in_nails',
    'inflammatory_nails',
    'blister',
    'red_sore_around_nose',
    'yellow_crust_ooze'
  ];

  selectCountry(String symptom, bool isSelected) {
    if (isSelected) {
      setState(() {
        selectedSymptoms.remove(symptom);
      });
    } else {
      setState(() {
        selectedSymptoms.add(symptom);
      });
    }
  }

  onSubmit() async {
    if (selectedSymptoms.length < 6) {
      return customStackBar(
          context: context, text: 'Please select select atleast 5 symptoms');
    }
    setState(() {
      isLoading = true;
    });
    String disease =
        await APImethods().predicDisease(symptoms: selectedSymptoms);
    setState(() {
      predicDisease = disease;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: predicDisease != null
          ? null
          : FloatingActionButton(
              onPressed: onSubmit,
              child: const Icon(Icons.done),
            ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'What are your',
                        style: TextStyles.textHeader1.copyWith(
                          fontSize: 40,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'symptoms?',
                        style: TextStyles.textHeader1.copyWith(
                          fontSize: 40,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Select more than 5 symptoms from following list',
                        style: TextStyles.textHeader1.copyWith(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                !isLoading
                    ? Expanded(
                        child: ListView(
                          children: symptoms.map((symptom) {
                            return SymptomCard(
                              symptom: symptom,
                              isSelected: false,
                              onSelected: selectCountry,
                            );
                          }).toList(),
                        ),
                      )
                    : Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Please wait.',
                            ),
                            SizedBox(height: 10),
                            CircularProgressIndicator(),
                          ],
                        ),
                      ),
              ],
            ),
            predicDisease != null
                ? Container(
                    color: Colors.grey.withOpacity(0.4),
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        color: CustomColors.white,
                        height: 150,
                        width: 200,
                        child: Center(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          predicDisease = null;
                                        });
                                      },
                                      icon: const Icon(Icons.close))
                                ],
                              ),
                              const Text(
                                'According to prediction....',
                              ),
                              const SizedBox(height: 10),
                              Text(
                                  'You might have ${predicDisease.toString()}'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
