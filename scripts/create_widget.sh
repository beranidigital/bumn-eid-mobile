#!/usr/bin/env bash

convertCamelCaseToLowerSnakeCase() {
    echo ${1} | sed 's/\([a-z0-9]\)\([A-Z]\)/\1_\2/g' | awk '{print tolower($0)}'
}

component_name=$1
component_graph_name="$1Graph"
component_name_snake_case=$(convertCamelCaseToLowerSnakeCase ${component_name})
component_graph_name_snake_case=$(convertCamelCaseToLowerSnakeCase ${component_graph_name})
project_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && dirname "$(pwd)" )"
file_location=${project_dir}/lib/ui/pages/${component_name_snake_case}/${component_name_snake_case}.dart
file_di_location=${project_dir}/lib/ui/pages/${component_name_snake_case}/di/${component_graph_name_snake_case}.dart

if [[ -e ${file_location} || -e ${file_di_location} ]]; then
    echo "Widget already created! Exiting"
    exit
fi

mkdir -p ${project_dir}/lib/ui/pages/${component_name_snake_case}
mkdir -p ${project_dir}/lib/ui/pages/${component_name_snake_case}/di

if [[ ! -e ${file_location} ]]; then
  cat > ${file_location} <<EOF
import 'package:flutter/material.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/ui/pages/${component_name_snake_case}/di/${component_graph_name_snake_case}.dart';

// ignore: must_be_immutable
class ${component_name} extends StatelessWidget with InjectableWidget {
    final ${component_graph_name} _graph;

    @override
    ${component_graph_name} graph() => _graph;

    ${component_name}([graph]) : this._graph = graph ?? ${component_graph_name}() {
        setup();
    }

    @override
    Widget build(BuildContext context) {
        return Container();
    }
}
EOF
fi

if [[ ! -e ${file_di_location} ]]; then
  cat > ${file_di_location} <<EOF
import 'package:injector/injector.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/ui/pages/${component_name_snake_case}/${component_name_snake_case}.dart';

class ${component_graph_name} extends Graph<${component_name}> {

  ${component_graph_name}([Injector injector]) : super(injector);

  // Inside this method, we inject the ${component_name} dependencies from injector to the instance
  @override
  void inject(${component_name} subject) {
    // For example: subject.store = getDependency<Store<AppState>>();
  }

  // Inside this method, we register all the ${component_name} dependencies:
  @override
  void register() {
  }
}
EOF
fi