import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'equipament_service_test.mocks.dart';
import 'package:flutter_test/flutter_test.dart';

@GenerateMocks([EquipamentService])
import 'package:mobile/api/equipament_service.dart';

void main() {
  late MockEquipamentService mockEquipamentService;

  setUp(() {
    mockEquipamentService = MockEquipamentService();
  });

  test('Retorna lista de equipamentos com getEquipaments', () async {
    final mockEquipaments = [
      {"id": "1", "name": "Equipamento A"},
      {"id": "2", "name": "Equipamento B"}
    ];

    when(mockEquipamentService.getEquipaments())
        .thenAnswer((_) async => mockEquipaments);

    final result = await mockEquipamentService.getEquipaments();
    expect(result, mockEquipaments);

    verify(mockEquipamentService.getEquipaments()).called(1);
  });

  test('Retorna dados de um equipamento com getOneEquipament', () async {
    final mockEquipamentData = {
      "id": "1",
      "name": "Equipamento A",
      "register": "1234"
    };

    when(mockEquipamentService.getOneEquipament("1234"))
        .thenAnswer((_) async => mockEquipamentData);

    final result = await mockEquipamentService.getOneEquipament("1234");
    expect(result, mockEquipamentData);

    verify(mockEquipamentService.getOneEquipament("1234")).called(1);
  });

  test('Atualiza localização dos equipamentos com updateEquipamentsLocation',
      () async {
    const mockMessage = "Equipamentos atualizados com sucesso";

    when(mockEquipamentService.updateEquipamentsLocation())
        .thenAnswer((_) async => mockMessage);

    final result = await mockEquipamentService.updateEquipamentsLocation();
    expect(result, mockMessage);

    verify(mockEquipamentService.updateEquipamentsLocation()).called(1);
  });
}
