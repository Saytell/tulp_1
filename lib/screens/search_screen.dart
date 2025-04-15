import 'package:flutter/material.dart';
import '/term_service.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  Map<String, List<String>> _results = {};

  bool _isLoading = false;
  String? _error;

  void _searchTerms() async {
    final query = _controller.text.trim();

    if (query.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Введите описание или термин')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
      _results = {};
    });

    try {
      final result = await TermService.searchTerms(query);
      setState(() {
        _results = result;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showDetails(String profession, String explanation) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profession,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text(
                explanation,
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 12),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  child: Text('Закрыть'),
                  onPressed: () => Navigator.pop(context),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildResults() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Text(
          'Ошибка: $_error',
          style: TextStyle(color: Colors.red),
          textAlign: TextAlign.center,
        ),
      );
    }

    if (_results.isEmpty) {
      return Text('Результаты появятся здесь');
    }

    return ListView(
      children: _results.entries.map((entry) {
        final profession = entry.key;
        final explanation = entry.value.first;

        return Card(
          child: ListTile(
            title: Text(profession),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () => _showDetails(profession, explanation),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Поиск термина')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Введите понятие или описание',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _searchTerms,
              icon: Icon(Icons.search),
              label: Text('Найти'),
            ),
            SizedBox(height: 16),
            Expanded(child: _buildResults()),
          ],
        ),
      ),
    );
  }
}
