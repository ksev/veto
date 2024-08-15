{ |before, after|
    if ("IN_NIX_SHELL" in $env) {
        return
    }
        
    if (($"($after)/flake.nix" | path exists)) {
        nix develop --command nu 
    }
    
    #if ("NIX_FLAKE_PATH" in $env) {
    #    try {
    #        $after | path relative-to $env.NIX_FLAKE_PATH;
    #    } catch {            
    #        hide-env NIX_FLAKE_PATH
    #        exit
    #    }

     #   if ($after == $env.NIX_FLAKE_PATH) {            
     #       return;
     #   }
    #}
    #if (($"($after)/flake.nix" | path exists)) {
    #    $env.NIX_FLAKE_PATH = $after

    #    if ("IN_NIX_SHELL" in $env) {
    #      hide-env NIX_FLAKE_PATH            
    #        exit
    #    }
        
    #    nix develop --command nu 
    #}
}
