class Quiz {
    const Quiz({
        required this.title,
        required this.description,
        required this.tags,
        required this.questions,
    });

    final String title;
    final String description;
    final List<String> tags;
    final String questions; 

    Quiz copyWith({
        final String? title,
        final String? description,
        final List<String>? tags,
        final String? questions,
    }) {
        return Quiz(
            title: title ?? this.title,
            description: description ?? this.description,
            tags: tags ?? this.tags,
            questions: questions ?? this.questions,
        );
    }
}