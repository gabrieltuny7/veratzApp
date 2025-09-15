// lib/home/home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

/// Cores
const _bgMenu = Color(0xFF1D1D27); // fundo da barra
const _duration = Duration(milliseconds: 700);

class _HomeState extends State<Home> {
  int _current = 0;

  // Itens da barra (SVG + cores da bolha e do fundo da página)
  final List<_NavItem> _items = const [
    _NavItem(
      label: 'Publicações',
      svgAsset: 'assets/icons/home.svg',
      bgBody: Color(0xFFFFB457),
      bgItem: Color(0xFFFF8C00),
    ),
    _NavItem(
      label: 'Bate-Papo',
      svgAsset: 'assets/icons/chat.svg',
      bgBody: Color(0xFFFF96BD),
      bgItem: Color(0xFFF54888),
    ),
    _NavItem(
      label: 'Publicar',
      svgAsset: 'assets/icons/add.svg',
      bgBody: Color(0xFF9999FB),
      bgItem: Color(0xFF4343F5),
    ),
    _NavItem(
      label: 'Perfil',
      svgAsset: 'assets/icons/perfil.svg',
      bgBody: Color(0xFFFFE797),
      bgItem: Color(0xFFE0B115),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: _duration,
      curve: Curves.easeOutCubic,
      color: _items[_current].bgBody, // muda a cor de fundo como no CSS/JS
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleSpacing: 0,
          leading: null, // sem sidebar
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/COLEGIO-VERATZ-LOGO.webp',
                  height: 28,
                ),
                const Spacer(),
              ],
            ),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: CircleAvatar(child: _ProfileIcon()),
            ),
          ],
        ),
        body: Center(
          child: Text(
            _items[_current].label,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.black.withOpacity(0.7),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        bottomNavigationBar: _FancyBottomBar(
          items: _items,
          currentIndex: _current,
          onItemSelected: (i) {
            setState(() => _current = i);
            if (_items[i].label == 'Sair') {
              // TODO: implemente sua lógica de logout aqui
            }
          },
        ),
      ),
    );
  }
}

class _NavItem {
  final String label;
  final String svgAsset;
  final Color bgBody;
  final Color bgItem;

  const _NavItem({
    required this.label,
    required this.svgAsset,
    required this.bgBody,
    required this.bgItem,
  });
}

/// Barra inferior custom com animações
class _FancyBottomBar extends StatelessWidget {
  final List<_NavItem> items;
  final int currentIndex;
  final ValueChanged<int> onItemSelected;

  const _FancyBottomBar({
    required this.items,
    required this.currentIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final itemWidth = constraints.maxWidth / items.length;
          final indicatorWidth = 110.0;
          final left =
              (currentIndex * itemWidth) + (itemWidth - indicatorWidth) / 2;

          return Container(
            height: 72,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: const BoxDecoration(
              color: _bgMenu,
              borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Indicador deslizante
                AnimatedPositioned(
                  duration: _duration,
                  curve: Curves.easeOutCubic,
                  left: left,
                  bottom: 62,
                  child: Container(
                    width: indicatorWidth,
                    height: 26,
                    decoration: const BoxDecoration(
                      color: _bgMenu,
                      borderRadius:
                      BorderRadius.vertical(top: Radius.circular(26)),
                    ),
                  ),
                ),
                // Itens
                Row(
                  children: List.generate(items.length, (index) {
                    final it = items[index];
                    final active = index == currentIndex;

                    return Expanded(
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => onItemSelected(index),
                        child: _FancyItem(
                          svgAsset: it.svgAsset,
                          label: it.label,
                          bgItem: it.bgItem,
                          active: active,
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _FancyItem extends StatelessWidget {
  final String svgAsset;
  final String label;
  final Color bgItem;
  final bool active;

  const _FancyItem({
    required this.svgAsset,
    required this.label,
    required this.bgItem,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: _duration,
      curve: Curves.easeOutCubic,
      transform: Matrix4.identity()..translate(0.0, active ? -8.0 : 0.0),
      padding: const EdgeInsets.only(top: 8, bottom: 12),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // círculo atrás do ícone
          AnimatedContainer(
            duration: _duration,
            width: active ? 48 : 0,
            height: active ? 48 : 0,
            decoration: BoxDecoration(
              color: bgItem,
              shape: BoxShape.circle,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                svgAsset,
                width: 28,
                height: 28,
                colorFilter:
                const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
              const SizedBox(height: 4),
              // Labels opcionais
              // AnimatedOpacity(
              //   opacity: active ? 1 : 0,
              //   duration: _duration,
              //   child: Text(
              //     label,
              //     style: const TextStyle(color: Colors.white, fontSize: 11),
              //     overflow: TextOverflow.ellipsis,
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}

enum Menu { itemOne, itemTwo, itemThree }

class _ProfileIcon extends StatelessWidget {
  const _ProfileIcon();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Menu>(
      icon: const Icon(Icons.person),
      offset: const Offset(0, 40),
      itemBuilder: (BuildContext context) => const <PopupMenuEntry<Menu>>[
        PopupMenuItem<Menu>(value: Menu.itemOne, child: Text('Conta')),
        PopupMenuItem<Menu>(value: Menu.itemTwo, child: Text('Configurações')),
        PopupMenuItem<Menu>(value: Menu.itemThree, child: Text('SAIR')),
      ],
    );
  }
}
