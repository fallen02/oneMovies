import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onemovies/models/search.dart';
import 'package:onemovies/providers/search_provider.dart';
import 'package:onemovies/screens/components/search_card.dart';
import 'package:onemovies/utils/icon_fonts.dart';

class SearchTab extends ConsumerStatefulWidget {
  const SearchTab({super.key});

  @override
  ConsumerState<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends ConsumerState<SearchTab> {
  final _controller = TextEditingController();
  Timer? _debounce;
  String _query = '';

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      setState(() {
        _query = query.trim();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final searchAsync = _query.isEmpty
        ? const AsyncValue<List<SearchResponse>>.data([])
        : ref.watch(searchProvider(_query));

    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              onChanged: _onSearchChanged,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Broken.search_normal, size: 20),
                prefixIconColor: WidgetStateColor.resolveWith(
                  (states) => states.contains(WidgetState.focused)
                      ? colors.primary
                      : colors.onSurface,
                ),
                suffixIcon: _query.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Broken.forbidden_2, size: 20),
                        onPressed: () {
                          _debounce?.cancel();
                          _controller.clear();
                          setState(() {
                            _query = '';
                          });
                        },
                      ),
                suffixIconColor: colors.primary,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: colors.primary),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),

            // ✅ Scrollable results
            Expanded(
              child: searchAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text(e.toString())),
                data: (results) {
                  if (_query.isEmpty) {
                    return const Center(
                      child: Text(
                        'Start typing to search',
                        style: TextStyle(
                          fontFamily: 'Ubuntu',
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }

                  if (results.isEmpty) {
                    return const Center(
                      child: Text(
                        'No results found',
                        style: TextStyle(
                          fontFamily: 'Ubuntu',
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      final item = results[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: SearchCard(result: item),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
