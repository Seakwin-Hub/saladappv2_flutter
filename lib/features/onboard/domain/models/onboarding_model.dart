class OnboardingModel {
  final String _title;
  final String _imageUrl;
  final String _description;

  get title => _title;
  get imageUrl => _imageUrl;
  get description => _description;

  OnboardingModel(this._description, this._imageUrl, this._title);
}
