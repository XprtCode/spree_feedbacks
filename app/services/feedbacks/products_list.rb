module Feedbacks
  class ProductsList
    attr_accessor :user, :store

    def initialize(user, store)
      @user = user
      @store = store
    end

    def do
      {
        line_items: line_items,
        products: products
      }
    end

    private

    def orders
      @_orders ||= user.orders.includes(:line_items).where(store_id: store.id)
        .where(state: :finished)
        .where('updated_at > ?', available_to_review_date)
    end

    def feedback_line_items_ids
      user.feedbacks.where(completed: true).map(&:spree_line_item_id).compact
    end

    def line_items
      return @_line_items if @_line_items.present?

      @_line_items = orders.map(&:line_items)
      @_line_items.flatten!
      @_line_items.sort_by!(&:updated_at)
      @_line_items.reject!{ |li| feedback_line_items_ids.include?(li.id) }
      @_line_items = @_line_items.group_by(&:variant_id)
      @_line_items = @_line_items.map{ |vid, items| items[0] }
    end

    def available_to_review_date
      @_available_to_review_date ||= Date.current - 90.days
    end

    def variant_ids
      @_variant_ids ||= line_items.map(&:variant_id).flatten
    end

    def product_ids
      @_product_ids ||= Spree::Variant.where(id: variant_ids).pluck(:product_id)
    end

    def view_searcher_products
      @_view_searcher_products ||= ViewSearcher.by_store(store.id)
        .where(product_id: product_ids).sort_by_name
    end

    def products_strains
      @_products_strains ||= ProductsStrains.get(view_searcher_products)
    end

    def processed_products
      @_processed_products ||= view_searcher_products._select!(&:in_stock)
    end

    def products
      @_products ||= ProcessProducts.new(processed_products, {}, products_strains).do
    end
  end
end
