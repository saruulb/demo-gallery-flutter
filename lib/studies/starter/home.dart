// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'dart:async';


import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/gallery_localizations.dart';
import 'package:gallery/layout/adaptive.dart';

const appBarDesktopHeight = 128.0;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final isDesktop = isDisplayDesktop(context);
    final localizations = GalleryLocalizations.of(context)!;

    String script_text = '''#!/bin/bash
    # Define the directory to retrieve information from
    sys_directory="/sys/"

    # Get a list of files in the sys directory
    file_list=(ls "SYS_DIRECTORY")

    # Iterate over each file in the directory
    for file in FILE_LIST; do
      # Check if the file is a regular file (not a directory or symlink)
      if [[ -f "SYS_DIRECTORYFILE" ]]; then
        # Read the contents of the file
        file_content= (cat "SYS_DIRECTORYFILE")
        
        # Echo the filename and its contents
        echo "<p><b>File: FILE</b></p>"
        echo "<pre> FILE_CONTENT</pre>"
      fi
    done''';

    final body = SafeArea(
      child: Padding(
        padding: isDesktop
            ? const EdgeInsets.symmetric(horizontal: 72, vertical: 48)
            : const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SelectableText(
              'Testing scripts',
              // localizations.starterAppGenericHeadline,
                style: textTheme.displaySmall!.copyWith(
                color: colorScheme.onSecondary,
              ),
            ),
            new Image(
                image: new AssetImage(
                  'assets/studies/animation_terminal.gif',
                  package: 'flutter_gallery_assets',
                  )
              ),
            // const SizedBox(height: 10),
            // SelectableText(
            //   localizations.starterAppGenericSubtitle,
            //   style: textTheme.titleMedium,
            // ),
            const SizedBox(height: 20),
            SelectableText.rich(
              TextSpan (text: script_text, style: TextStyle( fontStyle: FontStyle.italic)),
              // localizations.starterAppGenericBody,
              style: textTheme.bodyLarge,
              textAlign: TextAlign.center
            ),
          ],
        ),
      ),
    );

    if (isDesktop) {
      return Row(
        children: [
          const ListDrawer(),
          const VerticalDivider(width: 1),
          Expanded(
            child: Scaffold(
              appBar: const AdaptiveAppBar(
                isDesktop: true,
              ),
              body: body,
              floatingActionButton: FloatingActionButton.extended(
                heroTag: 'Extended Add',
                onPressed: () {},
                label: Text(
                  localizations.starterAppGenericButton,
                  style: TextStyle(color: colorScheme.onSecondary),
                ),
                icon: Icon(Icons.add, color: colorScheme.onSecondary),
                tooltip: localizations.starterAppTooltipAdd,
              ),
            ),
          ),
        ],
      );
    } else {
      return Scaffold(
        appBar: const AdaptiveAppBar(),
        body: Text('Hellooo'),
        drawer: const ListDrawer(),
        floatingActionButton: FloatingActionButton(
          heroTag: 'Add',
          onPressed: () {},
          tooltip: localizations.starterAppTooltipAdd,
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
      );
    }
  }
}

class AdaptiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AdaptiveAppBar({
    super.key,
    this.isDesktop = false,
  });

  final bool isDesktop;

  @override
  Size get preferredSize => isDesktop
      ? const Size.fromHeight(appBarDesktopHeight)
      : const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final localizations = GalleryLocalizations.of(context)!;
    return AppBar(
      automaticallyImplyLeading: !isDesktop,
      title: Text('Currently Working Scripts'),
      // bottom: isDesktop
      //     ? PreferredSize(
      //         preferredSize: const Size.fromHeight(26),
      //         child: Container(
      //           alignment: AlignmentDirectional.centerStart,
      //           margin: const EdgeInsetsDirectional.fromSTEB(72, 0, 0, 22),
      //           child: SelectableText(
      //             localizations.starterAppGenericTitle,
      //             style: themeData.textTheme.titleLarge!.copyWith(
      //               color: themeData.colorScheme.onPrimary,
      //             ),
      //           ),
      //         ),
      //       )
      //     : null,
      actions: [
        IconButton(
          icon: const Icon(Icons.share),
          tooltip: localizations.starterAppTooltipShare,
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.favorite),
          tooltip: localizations.starterAppTooltipFavorite,
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.search),
          tooltip: localizations.starterAppTooltipSearch,
          onPressed: () {},
        ),
      ],
    );
  }
}

class ListDrawer extends StatefulWidget {
  const ListDrawer({super.key});

  @override
  State<ListDrawer> createState() => _ListDrawerState();
}

class _ListDrawerState extends State<ListDrawer> {
  static const numItems = 1;

  int selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final localizations = GalleryLocalizations.of(context)!;
    return Drawer(
      child: SafeArea(
        child: ListView(
          children: [
            ListTile(
              title: SelectableText(
                localizations.starterAppTitle,
                style: textTheme.titleLarge,
              ),
              subtitle: SelectableText(
                localizations.starterAppGenericSubtitle,
                style: textTheme.bodyMedium,
              ),
            ),
            const Divider(),
            ...Iterable<int>.generate(numItems).toList().map((i) {
              return ListTile(
                enabled: true,
                selected: i == selectedItem,
                leading: const Icon(Icons.computer),
                title: Text(
                  "Monitor ${i}",
                ),
                onTap: () {
                  setState(() {
                    selectedItem = i;
                  });
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
