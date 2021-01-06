module CommentsHelper
    def generate_comment_level(parent_level, sibling_count = 0)
        parent_level + "." + (sibling_count + 1).to_s
    end
end
