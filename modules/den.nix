{ den, inputs, ... }: {
  imports = [
    inputs.den.flakeModule
    (inputs.den.namespace "tessro" false)
  ];

  config._module.args.__findFile = den.lib.__findFile;
}
