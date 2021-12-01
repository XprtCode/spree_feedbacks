module Feedbacks
  class Product
    attr_accessor :variant

    def initialize(variant)
      @variant = variant
    end

    def do
      products.try(&:first)
    end

    private

    def view_searcher_products
      @_view_searcher_products ||= ViewSearcher.by_store(variant.spree_store_id)
        .where(product_id: variant.product_id).sort_by_name
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
