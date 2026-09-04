class ProductsParams {
  final int limit;
  final int skip;
  final String? q;

  ProductsParams({
    this.limit = 20,
    this.skip = 0,
    this.q,
  });

  Map<String, dynamic> toJson() {
    return {
      'limit': limit,
      'skip': skip,
      if (q != null && q!.trim().isNotEmpty) 'q': q!.trim(),
    };
  }

  ProductsParams copyWith({
    int? limit,
    int? skip,
    String? q,
    bool resetQ = false,
  }) {
    return ProductsParams(
      limit: limit ?? this.limit,
      skip: skip ?? this.skip,
      q: resetQ ? null : (q ?? this.q),
    );
  }
}
