if Settings[:enable_panda_dashboard] or Panda.enable_panda_dashboard
  ActiveAdmin.register_page "SystemInfo" do
    menu priority: 11, label: proc { "系统信息" }

    content title: proc { "系统信息" } do

      panel "系统配置" do
        tag.pre JSON.pretty_generate Settings.as_json

      end
      panel "系统信息" do
        system = Ohai::System.new
        system.all_plugins
        info = system.to_json
        tag.pre JSON.pretty_generate(JSON.parse(info))
      end
      # Here is an example of a simple dashboard with columns and panels.
      #
      # columns do
      #   column do
      #     panel "Recent Posts" do
      #       ul do
      #         Post.recent(5).map do |post|
      #           li link_to(post.title, admin_post_path(post))
      #         end
      #       end
      #     end
      #   end

      #   column do
      #     panel "Info" do
      #       para "Welcome to ActiveAdmin."
      #     end
      #   end
      # end
    end # content
  end
end
