{
  programs.git = {
    enable = true;
    lfs.enable = true;
    ignores = [
      ".claude/settings.local.json"
      ".DS_Store"
      ".op"
      ".venv"
      "xcuserdata"
      "Session.vim"
    ];

    settings = {
      user = {
        name = "Tess Rosania";
        email = "tess.rosania@gmail.com";
      };

      alias = {
        aa = "add --all";
        ap = "add --patch";
        amend = "commit --amend";
        fix = "commit --amend -C HEAD";
        fnv = "commit --amend -C HEAD --no-verify";
        s = "status";
        w = "whatchanged";
        d = "diff";
        db = "diff --ignore-space-change";
        dc = "diff --cached";
        ds = "diff --stat";
        dom = "diff origin/main";
        b = "branch";
        l = "log";
        lb = "log --format=oneline origin/main..";
        lg = "log -i --grep";
        ll = "log -p";
        g = "log --graph --oneline --all";
        ci = "commit";
        cnv = "commit --no-verify";
        co = "checkout";
        r = "rebase";
        ra = "rebase --abort";
        rc = "rebase --continue";
        ri = "rebase -i";
        rom = "rebase origin/main";
        riom = "rebase -i origin/main";
        rn = "revert --no-commit";
        sta = "stash";
        sp = "stash pop";
        sl = "stash list";
        wip = "commit --no-verify -m wip";
        hist = ''log --pretty=format:"%h %ad | %s%d [%an]" --graph --date=short'';
        pullff = "pull --ff-only";
        mergeff = "merge --ff-only";
      };

      push.default = "current";

      filter = {
        hawser = {
          clean = "git hawser clean %f";
          smudge = "git hawser smudge %f";
          required = true;
        };

        media = {
          clean = "git-media-clean %f";
          smudge = "git-media-smudge %f";
        };
      };

      grep.lineNumber = true;

      pull = {
        ff = "only";
        rebase = true;
      };

      init.defaultBranch = "main";
      fetch.prune = true;
    };

    # This used to be relative to ~/.gitconfig. Home Manager writes its config
    # under ~/.config/git, so keep the include anchored in the home directory.
    includes = [ { path = "~/.gitconfig.local"; } ];
  };
}
