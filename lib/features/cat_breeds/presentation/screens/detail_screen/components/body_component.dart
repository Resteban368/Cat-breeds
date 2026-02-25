import 'package:cats_breeds/features/cat_breeds/domain/entities/breed_entity.dart';
import 'package:cats_breeds/features/cat_breeds/presentation/screens/detail_screen/widgets/cat_detail_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BodyComponent extends StatefulWidget {
  const BodyComponent({super.key, required this.breedEntity});
  final BreedEntity breedEntity;

  @override
  State<BodyComponent> createState() => _BodyComponentState();
}

class _BodyComponentState extends State<BodyComponent> {
  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: true,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          _description(),
          SizedBox(height: 20),
          _buildRichText(
            title: 'Country of Origin',
            value: widget.breedEntity.origin,
          ),
          SizedBox(height: 20),
          _buildRichText(
            title: 'Life Span',
            value: widget.breedEntity.lifeSpan,
          ),
          SizedBox(height: 20),
          _buildRichText(
            title: 'Abyssinian Temperament',
            value: widget.breedEntity.temperament,
          ),
          SizedBox(height: 20),
          _buildCatCharacteristic(),
          SizedBox(height: 20),
          _buildMoreInformation(),
        ],
      ),
    );
  }

  Column _buildMoreInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'More information:',
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.left,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildImageSizedBox(
              imageName: 'wikipedia',
              url: widget.breedEntity.wikipediaUrl,
            ),
            _buildImageSizedBox(
              imageName: 'vetstreet',
              url: widget.breedEntity.vetstreetUrl,
            ),
            _buildImageSizedBox(
              imageName: 'VCA',
              url: widget.breedEntity.vcahospitalsUrl,
            ),
          ],
        ),
      ],
    );
  }

  SizedBox _buildImageSizedBox({
    required String url,
    required String imageName,
  }) {
    return SizedBox(
      height: 50,
      child: IconButton(
        onPressed: () async {
          await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
        },
        icon: Image.asset('assets/images/$imageName.png'),
      ),
    );
  }

  Column _buildCatCharacteristic() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Breed characteristics: ',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              CatDetailsWidget(
                title: 'Adaptability',
                value: widget.breedEntity.adaptability,
              ),
              CatDetailsWidget(
                title: 'Intelligence',
                value: widget.breedEntity.intelligence,
              ),
              CatDetailsWidget(
                title: 'Social Needs',
                value: widget.breedEntity.socialNeeds,
              ),
              CatDetailsWidget(
                title: 'Affectionate',
                value: widget.breedEntity.affectionLevel,
              ),
              CatDetailsWidget(
                title: 'Child Friendly',
                value: widget.breedEntity.childFriendly,
              ),
              CatDetailsWidget(
                title: 'Cat Friendly',
                value: widget.breedEntity.catFriendly,
              ),
              CatDetailsWidget(
                title: 'Dog Friendly',
                value: widget.breedEntity.dogFriendly,
              ),
              CatDetailsWidget(
                title: 'Energy Level',
                value: widget.breedEntity.energyLevel,
              ),
            ],
          ),
        ),
      ],
    );
  }

  RichText _buildRichText({required String title, required String value}) {
    return RichText(
      text: TextSpan(
        text: '$title: ',
        style: Theme.of(context).textTheme.titleMedium,
        children: <TextSpan>[
          TextSpan(text: value, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }

  Text _description() {
    return Text(
      widget.breedEntity.description,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}
