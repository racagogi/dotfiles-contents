local root_files = {
	'Project.toml',
	'JuliaProject.toml',
}

local cmd = {
	'julia',
	'--startup-file=no',
	'--history-file=no',
	'-e',
	[[
    ls_install_path = joinpath( get(DEPOT_PATH, 1, joinpath(homedir(), ".julia")), "environments",)
    pushfirst!(LOAD_PATH, ls_install_path)
    using LanguageServer
    popfirst!(LOAD_PATH)
    project_path = let
        dirname(something(
            Base.load_path_expand((
                p = get(ENV, "JULIA_PROJECT", nothing);
                p === nothing ? nothing : isempty(p) ? nothing : p
            )),
            Base.current_project(),
            get(Base.load_path(), 1, nothing),
            Base.load_path_expand("@v#.#"),
        ))
    end
    @info "Running language server" VERSION pwd() project_path
    server = LanguageServer.LanguageServerInstance(stdin, stdout, project_path )
    server.runlinter = true
    run(server)
  ]],
}

require 'settings.languages.lsp'.setup('julia', 'julials', root_files, cmd, {})
