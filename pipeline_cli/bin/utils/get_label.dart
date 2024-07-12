String getLabel(List<String> labels) {
  final String label;

  if (labels.contains('Grosvenor') || labels.contains('grosvenor')) {
    label = 'Grosvenor';
  } else if (labels.contains('Mecca') || labels.contains('mecca')) {
    label = 'Mecca';
  } else {
    label = 'Unknown';
  }

  return 'Label: $label';
}
