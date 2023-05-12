enum PrioridadeEnum {
  selecione(value: ''),
  alta(value: 'alta'),
  baixa(value: 'baixa'),
  media(value: 'media');

  final String value;
  const PrioridadeEnum({required this.value});
}
