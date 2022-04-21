# Flutter VM Service Client for Frame Profiling

## Usage Guide

```
## Usage:
dart ./bin/vmservice_cli.dart <observatory_uri> <path_to_file.json>


## Example:
dart ./bin/vmservice_cli.dart ws://127.0.0.1:39255/_E1uPHKfjI8=/ws ~/Downloads/flutter-frame-log.json
```

Once the above command, in a few moments you wil see the file written with the frame debugging data. You can upload the data to https://iska.is/jank64 to visualize and see the entities resulting in long render times.
