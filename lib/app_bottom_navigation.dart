import 'package:flutter/material.dart';

class AppBottomNavigation extends StatelessWidget {
  const AppBottomNavigation({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.destinations,
  });

  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final List<NavigationDestination> destinations;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final dark = theme.brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
        border: Border(
          top: BorderSide(
            color: colors.outlineVariant.withValues(alpha: .85),
            width: .7,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: dark ? .24 : .08),
            blurRadius: 18,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(6, 8, 6, 4),
          child: Row(
            children: [
              for (final (index, destination) in destinations.indexed)
                Expanded(
                  child: Semantics(
                    container: true,
                    button: true,
                    selected: index == selectedIndex,
                    child: Tooltip(
                      message: destination.label,
                      excludeFromSemantics: true,
                      child: InkWell(
                        key: ValueKey('bottom-nav-$index'),
                        borderRadius: BorderRadius.circular(16),
                        onTap: () => onDestinationSelected(index),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            minHeight: 58,
                            minWidth: 48,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 180),
                                  curve: Curves.easeOutCubic,
                                  width: index == selectedIndex ? 48 : 42,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: index == selectedIndex
                                        ? colors.primaryContainer
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(11),
                                    border: index == selectedIndex
                                        ? Border.all(
                                            color: colors.primary.withValues(alpha: .14),
                                            width: .7,
                                          )
                                        : null,
                                    boxShadow: index == selectedIndex
                                        ? [
                                            BoxShadow(
                                              color: colors.primary.withValues(alpha: dark ? .16 : .08),
                                              blurRadius: 7,
                                              offset: const Offset(0, 2),
                                            ),
                                          ]
                                        : null,
                                  ),
                                  child: Center(
                                    child: IconTheme(
                                      data: IconThemeData(
                                        size: 22,
                                        color: index == selectedIndex
                                            ? colors.primary
                                            : colors.onSurfaceVariant,
                                      ),
                                      child: index == selectedIndex
                                          ? destination.selectedIcon ?? destination.icon
                                          : destination.icon,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  destination.label,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 11.5,
                                    height: 1.15,
                                    fontWeight: index == selectedIndex
                                        ? FontWeight.w700
                                        : FontWeight.w500,
                                    color: index == selectedIndex
                                        ? colors.primary
                                        : colors.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
