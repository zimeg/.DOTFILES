{ ... }:
{
  programs.zsh = {
    initContent = builtins.readFile ./worktrees.zsh;
    shellAliases = {
      z = "cd $(_zroot)";
      za = "_zw a";
      zb = "_zw b";
      zc = "_zw c";
      zd = "_zw d";
      ze = "_zw e";
      zf = "_zw f";
      zg = "_zw g";
      zh = "_zw h";
      zi = "_zw i";
      zj = "_zw j";
      zk = "_zw k";
      zl = "_zw l";
      zm = "_zw m";
      zn = "_zw n";
      zo = "_zw o";
      zp = "_zw p";
      zq = "_zw q";
      zr = "_zw r";
      zs = "_zw s";
      zt = "_zw t";
      zu = "_zw u";
      zv = "_zw v";
      zw = "_zw w";
      zx = "_zw x";
      zy = "_zw y";
      zz = "_zw z";
    };
  };
}
