import 'dart:convert';
import 'dart:io';

import 'package:vm_service/vm_service_io.dart';

Future<void> run(List<String> args) async {
  final String wsUrl = args.first.replaceFirst('http:', 'ws:');

  final String path = args[1];
  final File f = File(path);

  final conn = await vmServiceConnectUri('${wsUrl}ws');
  final vm = await conn.getVM();
  print(vm.isolates);

  final isolateID = vm.isolates!.first.id;

  final views = await conn.callServiceExtension(
    '_flutter.listViews',
    isolateId: isolateID,
  );

  final viewId = views.json?['views'][0]['id'];
  print('Got ViewID as $viewId.');

  const kRenderLastFrameWithRasterStatsMethod =
      '_flutter.renderFrameWithRasterStats';

  final response = await conn.callMethod(
    kRenderLastFrameWithRasterStatsMethod,
    isolateId: isolateID,
    args: <String, String?>{
      'viewId': viewId,
    },
  );

  conn.dispose();

  final json = response.json;
  final jsonString = jsonEncode(json);
  f.writeAsStringSync(jsonString);
}
