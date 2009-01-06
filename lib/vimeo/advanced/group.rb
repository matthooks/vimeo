module Vimeo
  module Advanced

    class Group < Vimeo::Advanced::Base

      # Fixme: Only takes group_id as int, not group name
      def get_members(group_id)
        sig_options = {
          :group_id => group_id,
          :method => "vimeo.groups.getMembers"
        }

        make_request sig_options
      end

    end

  end # Advanced
end # Vimeo