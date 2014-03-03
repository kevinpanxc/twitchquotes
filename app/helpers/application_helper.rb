module ApplicationHelper
	class PaginationListLinkRenderer < WillPaginate::ActionView::LinkRenderer
		protected

		def page_number(page)
			unless page == current_page
				link(page, page, :rel => rel_value(page))
			else
				link(page, "#", :class => 'active')
			end
		end

		def gap
			text = @template.will_paginate_translate(:page_gap) { '&hellip;' }
			%(<li class="disabled"><a>#{text}</a></li>)
		end

		def previous_page
			num = @collection.current_page > 1 && @collection.current_page - 1
			# previous_or_next_page(num, @options[:previous_label], 'previous_page')
			previous_or_next_page(num, '&laquo;', 'previous')
		end

		def next_page
			num = @collection.current_page < @collection.total_pages && @collection.current_page + 1
			# previous_or_next_page(num, @options[:next_label], 'next')
			previous_or_next_page(num, '&raquo;', 'next')
		end

		def previous_or_next_page(page, text, classname)
			if page
				link(text, page, :class => classname)
			else
				link(text, "#", :class => classname + ' disabled')
			end
		end

		def html_container(html)
			tag(:ul, html, container_attributes)
		end

		private

		def link(text, target, attributes = {})
			if target.is_a? Fixnum
				attributes[:rel] = rel_value(target)
				target = url(target)
			end

			unless target == "#"
				attributes[:href] = target
			end
			
			classname = attributes[:class]
			attributes.delete(:classname)
			tag(:li, tag(:a, text, attributes), :class => classname)
		end
	end

	def will_paginate(collection_or_options = nil, options = {})
		if collection_or_options.is_a? Hash
			options, collection_or_options = collection_or_options, nil
		end
		unless options[:renderer]
			options = options.merge :renderer => PaginationListLinkRenderer
		end
		super *[collection_or_options, options].compact
	end
end
