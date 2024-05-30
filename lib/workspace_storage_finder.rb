require 'json'
require 'pathname'

class WorkspaceStorageFinder
  class Error < StandardError; end
  class NotFoundError < Error; end

  def initialize(path:)
    @root = Pathname.new(path)
  end

  def find_path(needle:)
    needle = Pathname.new(needle).realpath.to_s
    worspace_storage_paths.each do |path|
      next unless path.exist?

      workspace_json_path = path.join('workspace.json')
      next unless workspace_json_path.exist?

      workspace_data = JSON.parse(workspace_json_path.read)
      folder_value = workspace_data['folder']
      return path if folder_value && folder_value == "file://#{needle}"
    end

    raise(NotFoundError, "Workspace storage not found for #{needle}. Searched in #{worspace_storage_paths.count} " \
      "folders within \"#{root}\".")
  end

  def worspace_storage_paths
    @worspace_storage_paths ||= root.children.select(&:directory?)
  end

  attr_reader :root
end
