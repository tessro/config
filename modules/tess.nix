{ den, ... }: {
  den.aspects.tess = {
    includes = [
      den.batteries.define-user
      den.batteries.primary-user
      (den.batteries.user-shell "zsh")
    ];

    homeManager = { };
  };
}
