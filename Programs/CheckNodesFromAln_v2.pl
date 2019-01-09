#This monstrosity checks to make sure things can speak to a node
#It requires a folder to exist called temp/
#Trees Must be rooted and named as follows  psbH.tre.rr
#Alignments must have a name to match: psbH.*
#Also a TrueTree.tre must exist with the tree to be mapped to
#Also you should probably have all of phyx downloaded
#Also this is hyper specific to this dataset (Sorry!)
#Verify that an alignment can speak to a node
use Data::Dumper;

open(StatsOut, ">>Results.txt")||die "No way!\n";
@array = ("Dont Use","Amborella_trichopoda|Illicium_oligandrum,Chloranthus_japonicus,Liriodendrom_tulipifera,Bismarckia_nobilis,Acorus_americanus,Berberis_bealei,Platanus_occidentalis,Trochodendron_aralioides,Buxus_microphylla,Prunus_padus,Liquidambar_formosana,Champereia_manillana,Haloxylon_ammodendron,Cornus_controversa,Camellia_oleifera,Acnistus_arborescens,Olea_europaea,Coffea_arabica,Helwingia_himalaica,Sambucus_williamsii,Viburnum_utile,Kolkwitzia_amabilis,Dendropanax_dentiger,Fatsia_japonica,Schefflera_heptaphylla,Aralia_undulata,Adenophora_remotiflora,Campanula_punctata,Lobelia_inflata,Centaurea_diffusa,Lactuca_sativa,Jacobaea_vulgaris,Ageratina_adenophora,Parthenium_argentatum,Galinsoga_quadriradiata,Anaphalis_sinica,Artemisa_frigida,Llerasia_caucana,Oritrophium_peruvianum,Diplostephium_oblanceolatum,Hinterhubera_ericoides,Diplostephium_hartwegii,Diplostephium_azureum,Diplostephium_meyenii,Diplostephium_foliosissimum,Diplostephium_pulchrum,Diplostephium_gnidioides,Diplostephium_oxapampanum,Diplostephium_haenkei,Diplostephium_empetrifolium","Illicium_oligandrum|Chloranthus_japonicus,Liriodendrom_tulipifera,Bismarckia_nobilis,Acorus_americanus,Berberis_bealei,Platanus_occidentalis,Trochodendron_aralioides,Buxus_microphylla,Prunus_padus,Liquidambar_formosana,Champereia_manillana,Haloxylon_ammodendron,Cornus_controversa,Camellia_oleifera,Acnistus_arborescens,Olea_europaea,Coffea_arabica,Helwingia_himalaica,Sambucus_williamsii,Viburnum_utile,Kolkwitzia_amabilis,Dendropanax_dentiger,Fatsia_japonica,Schefflera_heptaphylla,Aralia_undulata,Adenophora_remotiflora,Campanula_punctata,Lobelia_inflata,Centaurea_diffusa,Lactuca_sativa,Jacobaea_vulgaris,Ageratina_adenophora,Parthenium_argentatum,Galinsoga_quadriradiata,Anaphalis_sinica,Artemisa_frigida,Llerasia_caucana,Oritrophium_peruvianum,Diplostephium_oblanceolatum,Hinterhubera_ericoides,Diplostephium_hartwegii,Diplostephium_azureum,Diplostephium_meyenii,Diplostephium_foliosissimum,Diplostephium_pulchrum,Diplostephium_gnidioides,Diplostephium_oxapampanum,Diplostephium_haenkei,Diplostephium_empetrifolium","Chloranthus_japonicus,Liriodendrom_tulipifera|Bismarckia_nobilis,Acorus_americanus,Berberis_bealei,Platanus_occidentalis,Trochodendron_aralioides,Buxus_microphylla,Prunus_padus,Liquidambar_formosana,Champereia_manillana,Haloxylon_ammodendron,Cornus_controversa,Camellia_oleifera,Acnistus_arborescens,Olea_europaea,Coffea_arabica,Helwingia_himalaica,Sambucus_williamsii,Viburnum_utile,Kolkwitzia_amabilis,Dendropanax_dentiger,Fatsia_japonica,Schefflera_heptaphylla,Aralia_undulata,Adenophora_remotiflora,Campanula_punctata,Lobelia_inflata,Centaurea_diffusa,Lactuca_sativa,Jacobaea_vulgaris,Ageratina_adenophora,Parthenium_argentatum,Galinsoga_quadriradiata,Anaphalis_sinica,Artemisa_frigida,Llerasia_caucana,Oritrophium_peruvianum,Diplostephium_oblanceolatum,Hinterhubera_ericoides,Diplostephium_hartwegii,Diplostephium_azureum,Diplostephium_meyenii,Diplostephium_foliosissimum,Diplostephium_pulchrum,Diplostephium_gnidioides,Diplostephium_oxapampanum,Diplostephium_haenkei,Diplostephium_empetrifolium","Chloranthus_japonicus|Liriodendrom_tulipifera","Bismarckia_nobilis,Acorus_americanus|Berberis_bealei,Platanus_occidentalis,Trochodendron_aralioides,Buxus_microphylla,Prunus_padus,Liquidambar_formosana,Champereia_manillana,Haloxylon_ammodendron,Cornus_controversa,Camellia_oleifera,Acnistus_arborescens,Olea_europaea,Coffea_arabica,Helwingia_himalaica,Sambucus_williamsii,Viburnum_utile,Kolkwitzia_amabilis,Dendropanax_dentiger,Fatsia_japonica,Schefflera_heptaphylla,Aralia_undulata,Adenophora_remotiflora,Campanula_punctata,Lobelia_inflata,Centaurea_diffusa,Lactuca_sativa,Jacobaea_vulgaris,Ageratina_adenophora,Parthenium_argentatum,Galinsoga_quadriradiata,Anaphalis_sinica,Artemisa_frigida,Llerasia_caucana,Oritrophium_peruvianum,Diplostephium_oblanceolatum,Hinterhubera_ericoides,Diplostephium_hartwegii,Diplostephium_azureum,Diplostephium_meyenii,Diplostephium_foliosissimum,Diplostephium_pulchrum,Diplostephium_gnidioides,Diplostephium_oxapampanum,Diplostephium_haenkei,Diplostephium_empetrifolium","Bismarckia_nobilis|Acorus_americanus","Berberis_bealei|Platanus_occidentalis,Trochodendron_aralioides,Buxus_microphylla,Prunus_padus,Liquidambar_formosana,Champereia_manillana,Haloxylon_ammodendron,Cornus_controversa,Camellia_oleifera,Acnistus_arborescens,Olea_europaea,Coffea_arabica,Helwingia_himalaica,Sambucus_williamsii,Viburnum_utile,Kolkwitzia_amabilis,Dendropanax_dentiger,Fatsia_japonica,Schefflera_heptaphylla,Aralia_undulata,Adenophora_remotiflora,Campanula_punctata,Lobelia_inflata,Centaurea_diffusa,Lactuca_sativa,Jacobaea_vulgaris,Ageratina_adenophora,Parthenium_argentatum,Galinsoga_quadriradiata,Anaphalis_sinica,Artemisa_frigida,Llerasia_caucana,Oritrophium_peruvianum,Diplostephium_oblanceolatum,Hinterhubera_ericoides,Diplostephium_hartwegii,Diplostephium_azureum,Diplostephium_meyenii,Diplostephium_foliosissimum,Diplostephium_pulchrum,Diplostephium_gnidioides,Diplostephium_oxapampanum,Diplostephium_haenkei,Diplostephium_empetrifolium","Platanus_occidentalis|Trochodendron_aralioides,Buxus_microphylla,Prunus_padus,Liquidambar_formosana,Champereia_manillana,Haloxylon_ammodendron,Cornus_controversa,Camellia_oleifera,Acnistus_arborescens,Olea_europaea,Coffea_arabica,Helwingia_himalaica,Sambucus_williamsii,Viburnum_utile,Kolkwitzia_amabilis,Dendropanax_dentiger,Fatsia_japonica,Schefflera_heptaphylla,Aralia_undulata,Adenophora_remotiflora,Campanula_punctata,Lobelia_inflata,Centaurea_diffusa,Lactuca_sativa,Jacobaea_vulgaris,Ageratina_adenophora,Parthenium_argentatum,Galinsoga_quadriradiata,Anaphalis_sinica,Artemisa_frigida,Llerasia_caucana,Oritrophium_peruvianum,Diplostephium_oblanceolatum,Hinterhubera_ericoides,Diplostephium_hartwegii,Diplostephium_azureum,Diplostephium_meyenii,Diplostephium_foliosissimum,Diplostephium_pulchrum,Diplostephium_gnidioides,Diplostephium_oxapampanum,Diplostephium_haenkei,Diplostephium_empetrifolium","Trochodendron_aralioides|Buxus_microphylla,Prunus_padus,Liquidambar_formosana,Champereia_manillana,Haloxylon_ammodendron,Cornus_controversa,Camellia_oleifera,Acnistus_arborescens,Olea_europaea,Coffea_arabica,Helwingia_himalaica,Sambucus_williamsii,Viburnum_utile,Kolkwitzia_amabilis,Dendropanax_dentiger,Fatsia_japonica,Schefflera_heptaphylla,Aralia_undulata,Adenophora_remotiflora,Campanula_punctata,Lobelia_inflata,Centaurea_diffusa,Lactuca_sativa,Jacobaea_vulgaris,Ageratina_adenophora,Parthenium_argentatum,Galinsoga_quadriradiata,Anaphalis_sinica,Artemisa_frigida,Llerasia_caucana,Oritrophium_peruvianum,Diplostephium_oblanceolatum,Hinterhubera_ericoides,Diplostephium_hartwegii,Diplostephium_azureum,Diplostephium_meyenii,Diplostephium_foliosissimum,Diplostephium_pulchrum,Diplostephium_gnidioides,Diplostephium_oxapampanum,Diplostephium_haenkei,Diplostephium_empetrifolium","Buxus_microphylla|Prunus_padus,Liquidambar_formosana,Champereia_manillana,Haloxylon_ammodendron,Cornus_controversa,Camellia_oleifera,Acnistus_arborescens,Olea_europaea,Coffea_arabica,Helwingia_himalaica,Sambucus_williamsii,Viburnum_utile,Kolkwitzia_amabilis,Dendropanax_dentiger,Fatsia_japonica,Schefflera_heptaphylla,Aralia_undulata,Adenophora_remotiflora,Campanula_punctata,Lobelia_inflata,Centaurea_diffusa,Lactuca_sativa,Jacobaea_vulgaris,Ageratina_adenophora,Parthenium_argentatum,Galinsoga_quadriradiata,Anaphalis_sinica,Artemisa_frigida,Llerasia_caucana,Oritrophium_peruvianum,Diplostephium_oblanceolatum,Hinterhubera_ericoides,Diplostephium_hartwegii,Diplostephium_azureum,Diplostephium_meyenii,Diplostephium_foliosissimum,Diplostephium_pulchrum,Diplostephium_gnidioides,Diplostephium_oxapampanum,Diplostephium_haenkei,Diplostephium_empetrifolium","Prunus_padus,Liquidambar_formosana|Champereia_manillana,Haloxylon_ammodendron,Cornus_controversa,Camellia_oleifera,Acnistus_arborescens,Olea_europaea,Coffea_arabica,Helwingia_himalaica,Sambucus_williamsii,Viburnum_utile,Kolkwitzia_amabilis,Dendropanax_dentiger,Fatsia_japonica,Schefflera_heptaphylla,Aralia_undulata,Adenophora_remotiflora,Campanula_punctata,Lobelia_inflata,Centaurea_diffusa,Lactuca_sativa,Jacobaea_vulgaris,Ageratina_adenophora,Parthenium_argentatum,Galinsoga_quadriradiata,Anaphalis_sinica,Artemisa_frigida,Llerasia_caucana,Oritrophium_peruvianum,Diplostephium_oblanceolatum,Hinterhubera_ericoides,Diplostephium_hartwegii,Diplostephium_azureum,Diplostephium_meyenii,Diplostephium_foliosissimum,Diplostephium_pulchrum,Diplostephium_gnidioides,Diplostephium_oxapampanum,Diplostephium_haenkei,Diplostephium_empetrifolium","Prunus_padus|Liquidambar_formosana","Champereia_manillana|Haloxylon_ammodendron,Cornus_controversa,Camellia_oleifera,Acnistus_arborescens,Olea_europaea,Coffea_arabica,Helwingia_himalaica,Sambucus_williamsii,Viburnum_utile,Kolkwitzia_amabilis,Dendropanax_dentiger,Fatsia_japonica,Schefflera_heptaphylla,Aralia_undulata,Adenophora_remotiflora,Campanula_punctata,Lobelia_inflata,Centaurea_diffusa,Lactuca_sativa,Jacobaea_vulgaris,Ageratina_adenophora,Parthenium_argentatum,Galinsoga_quadriradiata,Anaphalis_sinica,Artemisa_frigida,Llerasia_caucana,Oritrophium_peruvianum,Diplostephium_oblanceolatum,Hinterhubera_ericoides,Diplostephium_hartwegii,Diplostephium_azureum,Diplostephium_meyenii,Diplostephium_foliosissimum,Diplostephium_pulchrum,Diplostephium_gnidioides,Diplostephium_oxapampanum,Diplostephium_haenkei,Diplostephium_empetrifolium","Haloxylon_ammodendron|Cornus_controversa,Camellia_oleifera,Acnistus_arborescens,Olea_europaea,Coffea_arabica,Helwingia_himalaica,Sambucus_williamsii,Viburnum_utile,Kolkwitzia_amabilis,Dendropanax_dentiger,Fatsia_japonica,Schefflera_heptaphylla,Aralia_undulata,Adenophora_remotiflora,Campanula_punctata,Lobelia_inflata,Centaurea_diffusa,Lactuca_sativa,Jacobaea_vulgaris,Ageratina_adenophora,Parthenium_argentatum,Galinsoga_quadriradiata,Anaphalis_sinica,Artemisa_frigida,Llerasia_caucana,Oritrophium_peruvianum,Diplostephium_oblanceolatum,Hinterhubera_ericoides,Diplostephium_hartwegii,Diplostephium_azureum,Diplostephium_meyenii,Diplostephium_foliosissimum,Diplostephium_pulchrum,Diplostephium_gnidioides,Diplostephium_oxapampanum,Diplostephium_haenkei,Diplostephium_empetrifolium","Cornus_controversa|Camellia_oleifera,Acnistus_arborescens,Olea_europaea,Coffea_arabica,Helwingia_himalaica,Sambucus_williamsii,Viburnum_utile,Kolkwitzia_amabilis,Dendropanax_dentiger,Fatsia_japonica,Schefflera_heptaphylla,Aralia_undulata,Adenophora_remotiflora,Campanula_punctata,Lobelia_inflata,Centaurea_diffusa,Lactuca_sativa,Jacobaea_vulgaris,Ageratina_adenophora,Parthenium_argentatum,Galinsoga_quadriradiata,Anaphalis_sinica,Artemisa_frigida,Llerasia_caucana,Oritrophium_peruvianum,Diplostephium_oblanceolatum,Hinterhubera_ericoides,Diplostephium_hartwegii,Diplostephium_azureum,Diplostephium_meyenii,Diplostephium_foliosissimum,Diplostephium_pulchrum,Diplostephium_gnidioides,Diplostephium_oxapampanum,Diplostephium_haenkei,Diplostephium_empetrifolium","Camellia_oleifera|Acnistus_arborescens,Olea_europaea,Coffea_arabica,Helwingia_himalaica,Sambucus_williamsii,Viburnum_utile,Kolkwitzia_amabilis,Dendropanax_dentiger,Fatsia_japonica,Schefflera_heptaphylla,Aralia_undulata,Adenophora_remotiflora,Campanula_punctata,Lobelia_inflata,Centaurea_diffusa,Lactuca_sativa,Jacobaea_vulgaris,Ageratina_adenophora,Parthenium_argentatum,Galinsoga_quadriradiata,Anaphalis_sinica,Artemisa_frigida,Llerasia_caucana,Oritrophium_peruvianum,Diplostephium_oblanceolatum,Hinterhubera_ericoides,Diplostephium_hartwegii,Diplostephium_azureum,Diplostephium_meyenii,Diplostephium_foliosissimum,Diplostephium_pulchrum,Diplostephium_gnidioides,Diplostephium_oxapampanum,Diplostephium_haenkei,Diplostephium_empetrifolium","Acnistus_arborescens,Olea_europaea,Coffea_arabica|Helwingia_himalaica,Sambucus_williamsii,Viburnum_utile,Kolkwitzia_amabilis,Dendropanax_dentiger,Fatsia_japonica,Schefflera_heptaphylla,Aralia_undulata,Adenophora_remotiflora,Campanula_punctata,Lobelia_inflata,Centaurea_diffusa,Lactuca_sativa,Jacobaea_vulgaris,Ageratina_adenophora,Parthenium_argentatum,Galinsoga_quadriradiata,Anaphalis_sinica,Artemisa_frigida,Llerasia_caucana,Oritrophium_peruvianum,Diplostephium_oblanceolatum,Hinterhubera_ericoides,Diplostephium_hartwegii,Diplostephium_azureum,Diplostephium_meyenii,Diplostephium_foliosissimum,Diplostephium_pulchrum,Diplostephium_gnidioides,Diplostephium_oxapampanum,Diplostephium_haenkei,Diplostephium_empetrifolium","Acnistus_arborescens|Olea_europaea,Coffea_arabica","Olea_europaea|Coffea_arabica","Helwingia_himalaica|Sambucus_williamsii,Viburnum_utile,Kolkwitzia_amabilis,Dendropanax_dentiger,Fatsia_japonica,Schefflera_heptaphylla,Aralia_undulata,Adenophora_remotiflora,Campanula_punctata,Lobelia_inflata,Centaurea_diffusa,Lactuca_sativa,Jacobaea_vulgaris,Ageratina_adenophora,Parthenium_argentatum,Galinsoga_quadriradiata,Anaphalis_sinica,Artemisa_frigida,Llerasia_caucana,Oritrophium_peruvianum,Diplostephium_oblanceolatum,Hinterhubera_ericoides,Diplostephium_hartwegii,Diplostephium_azureum,Diplostephium_meyenii,Diplostephium_foliosissimum,Diplostephium_pulchrum,Diplostephium_gnidioides,Diplostephium_oxapampanum,Diplostephium_haenkei,Diplostephium_empetrifolium","Sambucus_williamsii,Viburnum_utile,Kolkwitzia_amabilis,Dendropanax_dentiger,Fatsia_japonica,Schefflera_heptaphylla,Aralia_undulata|Adenophora_remotiflora,Campanula_punctata,Lobelia_inflata,Centaurea_diffusa,Lactuca_sativa,Jacobaea_vulgaris,Ageratina_adenophora,Parthenium_argentatum,Galinsoga_quadriradiata,Anaphalis_sinica,Artemisa_frigida,Llerasia_caucana,Oritrophium_peruvianum,Diplostephium_oblanceolatum,Hinterhubera_ericoides,Diplostephium_hartwegii,Diplostephium_azureum,Diplostephium_meyenii,Diplostephium_foliosissimum,Diplostephium_pulchrum,Diplostephium_gnidioides,Diplostephium_oxapampanum,Diplostephium_haenkei,Diplostephium_empetrifolium","Sambucus_williamsii,Viburnum_utile,Kolkwitzia_amabilis|Dendropanax_dentiger,Fatsia_japonica,Schefflera_heptaphylla,Aralia_undulata","Sambucus_williamsii,Viburnum_utile|Kolkwitzia_amabilis","Sambucus_williamsii|Viburnum_utile","Dendropanax_dentiger,Fatsia_japonica,Schefflera_heptaphylla|Aralia_undulata","Dendropanax_dentiger,Fatsia_japonica|Schefflera_heptaphylla","Dendropanax_dentiger|Fatsia_japonica","Adenophora_remotiflora,Campanula_punctata,Lobelia_inflata|Centaurea_diffusa,Lactuca_sativa,Jacobaea_vulgaris,Ageratina_adenophora,Parthenium_argentatum,Galinsoga_quadriradiata,Anaphalis_sinica,Artemisa_frigida,Llerasia_caucana,Oritrophium_peruvianum,Diplostephium_oblanceolatum,Hinterhubera_ericoides,Diplostephium_hartwegii,Diplostephium_azureum,Diplostephium_meyenii,Diplostephium_foliosissimum,Diplostephium_pulchrum,Diplostephium_gnidioides,Diplostephium_oxapampanum,Diplostephium_haenkei,Diplostephium_empetrifolium","Adenophora_remotiflora,Campanula_punctata|Lobelia_inflata","Adenophora_remotiflora|Campanula_punctata","Centaurea_diffusa|Lactuca_sativa,Jacobaea_vulgaris,Ageratina_adenophora,Parthenium_argentatum,Galinsoga_quadriradiata,Anaphalis_sinica,Artemisa_frigida,Llerasia_caucana,Oritrophium_peruvianum,Diplostephium_oblanceolatum,Hinterhubera_ericoides,Diplostephium_hartwegii,Diplostephium_azureum,Diplostephium_meyenii,Diplostephium_foliosissimum,Diplostephium_pulchrum,Diplostephium_gnidioides,Diplostephium_oxapampanum,Diplostephium_haenkei,Diplostephium_empetrifolium","Lactuca_sativa|Jacobaea_vulgaris,Ageratina_adenophora,Parthenium_argentatum,Galinsoga_quadriradiata,Anaphalis_sinica,Artemisa_frigida,Llerasia_caucana,Oritrophium_peruvianum,Diplostephium_oblanceolatum,Hinterhubera_ericoides,Diplostephium_hartwegii,Diplostephium_azureum,Diplostephium_meyenii,Diplostephium_foliosissimum,Diplostephium_pulchrum,Diplostephium_gnidioides,Diplostephium_oxapampanum,Diplostephium_haenkei,Diplostephium_empetrifolium","Jacobaea_vulgaris|Ageratina_adenophora,Parthenium_argentatum,Galinsoga_quadriradiata,Anaphalis_sinica,Artemisa_frigida,Llerasia_caucana,Oritrophium_peruvianum,Diplostephium_oblanceolatum,Hinterhubera_ericoides,Diplostephium_hartwegii,Diplostephium_azureum,Diplostephium_meyenii,Diplostephium_foliosissimum,Diplostephium_pulchrum,Diplostephium_gnidioides,Diplostephium_oxapampanum,Diplostephium_haenkei,Diplostephium_empetrifolium","Ageratina_adenophora,Parthenium_argentatum,Galinsoga_quadriradiata|Anaphalis_sinica,Artemisa_frigida,Llerasia_caucana,Oritrophium_peruvianum,Diplostephium_oblanceolatum,Hinterhubera_ericoides,Diplostephium_hartwegii,Diplostephium_azureum,Diplostephium_meyenii,Diplostephium_foliosissimum,Diplostephium_pulchrum,Diplostephium_gnidioides,Diplostephium_oxapampanum,Diplostephium_haenkei,Diplostephium_empetrifolium","Ageratina_adenophora,Parthenium_argentatum|Galinsoga_quadriradiata","Ageratina_adenophora|Parthenium_argentatum","Anaphalis_sinica|Artemisa_frigida,Llerasia_caucana,Oritrophium_peruvianum,Diplostephium_oblanceolatum,Hinterhubera_ericoides,Diplostephium_hartwegii,Diplostephium_azureum,Diplostephium_meyenii,Diplostephium_foliosissimum,Diplostephium_pulchrum,Diplostephium_gnidioides,Diplostephium_oxapampanum,Diplostephium_haenkei,Diplostephium_empetrifolium","Artemisa_frigida|Llerasia_caucana,Oritrophium_peruvianum,Diplostephium_oblanceolatum,Hinterhubera_ericoides,Diplostephium_hartwegii,Diplostephium_azureum,Diplostephium_meyenii,Diplostephium_foliosissimum,Diplostephium_pulchrum,Diplostephium_gnidioides,Diplostephium_oxapampanum,Diplostephium_haenkei,Diplostephium_empetrifolium","Llerasia_caucana|Oritrophium_peruvianum,Diplostephium_oblanceolatum,Hinterhubera_ericoides,Diplostephium_hartwegii,Diplostephium_azureum,Diplostephium_meyenii,Diplostephium_foliosissimum,Diplostephium_pulchrum,Diplostephium_gnidioides,Diplostephium_oxapampanum,Diplostephium_haenkei,Diplostephium_empetrifolium","Oritrophium_peruvianum|Diplostephium_oblanceolatum,Hinterhubera_ericoides,Diplostephium_hartwegii,Diplostephium_azureum,Diplostephium_meyenii,Diplostephium_foliosissimum,Diplostephium_pulchrum,Diplostephium_gnidioides,Diplostephium_oxapampanum,Diplostephium_haenkei,Diplostephium_empetrifolium","Diplostephium_oblanceolatum,Hinterhubera_ericoides,Diplostephium_hartwegii,Diplostephium_azureum|Diplostephium_meyenii,Diplostephium_foliosissimum,Diplostephium_pulchrum,Diplostephium_gnidioides,Diplostephium_oxapampanum,Diplostephium_haenkei,Diplostephium_empetrifolium","Diplostephium_oblanceolatum,Hinterhubera_ericoides|Diplostephium_hartwegii,Diplostephium_azureum","Diplostephium_oblanceolatum|Hinterhubera_ericoides","Diplostephium_hartwegii|Diplostephium_azureum","Diplostephium_meyenii|Diplostephium_foliosissimum,Diplostephium_pulchrum,Diplostephium_gnidioides,Diplostephium_oxapampanum,Diplostephium_haenkei,Diplostephium_empetrifolium","Diplostephium_foliosissimum,Diplostephium_pulchrum,Diplostephium_gnidioides,Diplostephium_oxapampanum,Diplostephium_haenkei|Diplostephium_empetrifolium","Diplostephium_foliosissimum|Diplostephium_pulchrum,Diplostephium_gnidioides,Diplostephium_oxapampanum,Diplostephium_haenkei","Diplostephium_pulchrum,Diplostephium_gnidioides|Diplostephium_oxapampanum,Diplostephium_haenkei","Diplostephium_pulchrum|Diplostephium_gnidioides","Diplostephium_oxapampanum|Diplostephium_haenkei",);
open(fasta, $ARGV[0])||die "perl CheckNodesFromAln.pl GeneToCheck.fa FolderWithTrees";
while($line = <fasta>){

	chomp $line;
	if($line =~ /^>/){
		
		$name = ($line =~ m/>(.*)/)[0];
		$HASH{$name} = $name;

	}
	
	
}
#print Dumper(\%HASH);
$tot_tax = keys %HASH;

%cant_hash = ();
$cant_count = 0;
$total_nodes = 0;
$analyzable = 0;
#skip first since first bipart speaks to nothing relevant
foreach $i (1..$#array){
	
	$clade_one_good = "true"; $clade_two_good = "true";
	($clade_one,$clade_two) = split /\|/, $array[$i];
	@clade1_array = split ",", $clade_one;
	@clade2_array = split ",", $clade_two;
	$count_one = 0;
	$cant_analyze = "false";
	foreach $j (0..$#clade1_array){
		
		if(exists $HASH{$clade1_array[$j]}){
			$count_one++;
		}
	}
	if($count != ($#clade1_array+1)){
		#print "$array[$i]\n";
	}
	$count_two = 0;
	foreach $j (0..$#clade2_array){
		
		if(exists $HASH{$clade2_array[$j]}){
			$count_two++;
		}
	}

	if($count_one == 0){
		$cant_analyze = "true";
	}
	if($count_two == 0){
		$cant_analyze = "true";
	}
	if($cant_analyze eq "true"){
		
		print "$array[$i]\n";
		$cant_hash{$i} = $i;
		$cant_count++;
	}
	$total_nodes++;
}
$analyzable = $total_nodes - $cant_count;
#print Dumper(\%cant_hash);
#Genus Level
#12 nodes
#0-30
@Genus = ("40","41","42","43","44","45","46","47","48","49","50","30");
%Genus_hash = map {$_ => 1} @Genus;
$Genus = 0;
#Super Order Level
#9 nodes
#30-60
@SO = ("31","32","33","34","35","36","37","38","39");
%SO_hash = map {$_ => 1} @SO;
$sup_order = 0;
#Order Level
#10
#60-90
@Order = ("18","19","22","23","24","25","26","27","28","29");
%Order_hash = map {$_ => 1} @Order; 
$order = 0;
#Family Level
#7
#90-120
@Family = ("14","15","16","17","4","20","21");
%Family_hash = map {$_ => 1} @Family;
$family = 0;
#Angio
#12
#120-150
@Angio = ("1","2","3","5","6","7","8","9","10","11","12","13");
%Angio_hash = map {$_ => 1} @Angio;
$angio = 0;
$total = 0;
#$input = $ARGV[1];
$tree = ($ARGV[0] =~ m/.*?\/(.*?)\..*/)[0];
#print "$tree\n";
$folder = $ARGV[1];
system("cp $folder$tree\.tre\.rr temp");
system("java -jar ../../phyparts/target/phyparts-0.0.1-SNAPSHOT-jar-with-dependencies.jar -a 1 -d temp/ -m TrueTree.tre -v");
system("rm temp/$tree\.tre\.rr");
system("ls out.concord* > hold.txt");
open(new, "hold.txt")||die "No concordant";
while($file = <new>){
	
	chomp $file;
	$hit = ($file =~ m/concord.node.(.*)/)[0];
	if(exists $Angio_hash{$hit}){
		$angio += 1;
		$total++;
	}
	if(exists $SO_hash{$hit}){
		$sup_order += 1;
		$total++;
	}
	if(exists $Order_hash{$hit}){
		$order += 1;
		$total++;
	}
	if(exists $Family_hash{$hit}){
		$family += 1;
		$total++;
	}
	if(exists $Genus_hash{$hit}){
		$genus += 1;
		$total++;
	}
}
if($ARGV[2] eq "True"){

		print StatsOut "GeneName\tTotalTaxa\tTotalSupportableNodes\tTotalNodesSupported\tTotalNotSupported\t120-150S\t120-150NS\t90-120S\t90-120NS\t60-90S\t60-90NS\t30-60S\t30-60NS\t0-30S\t0-30NS\tTotalSupportedBs\tTotalNoSupportBs\t120-150Sbs\t150-120NSbs\t90-120Sbs\t90-120NSbs\t60-90Sbs\t60-90NSbs\t30-60Sbs\t30-60NSbs\t0-30Sbs\t0-30NSbs\tlength\tvariance\n";
		#die;
}
$not_sup = $analyzable - $total;
#print Dumper(\@Angio);
$angio_not = 0;
$fam_not = 0;
$sup_not = 0;
$order_not = 0;
$genus_not = 0;

foreach $keys (keys %cant_hash){

	if(exists $Angio_hash{$keys}){
		$angio_not++;
	}
	if(exists $Family_hash{$keys}){
	
		$fam_not++;
	}
	if(exists $SO_hash{$keys}){
		$sup_not++;
	}
	if(exists $Order_hash{$keys}){
		$order_not++;
	}
	if(exists $Genus_hash{$keys}){
		$genus_not++;
	}
}
#print Dumper(\@Angio);
$AngioAvail = ($#Angio + 1) - $angio_not;
$AngioNS = $AngioAvail - $angio;
$FamAvail = ($#Family + 1) - $fam_not;
$FamNS = $FamAvail - $family;
$OrderAvail = ($#Order + 1) - $order_not;
$OrderNS = $OrderAvail - $order;
$SupAvail = ($#SO + 1) - $sup_not;
$SupNS = $SupAvail - $sup_order;
$GenusAvail = ($#Genus + 1) - $genus_not;
$GenusNS = $GenusAvail - $genus;
system("rm hold.txt out.*");
##################
#Do the same but with support added in
system("cp $folder$tree\.tre\.rr temp");
system("java -jar ../../phyparts/target/phyparts-0.0.1-SNAPSHOT-jar-with-dependencies.jar -a 1 -s 70 -d temp/ -m TrueTree.tre -v");

system("ls out.concord* > hold.txt");
#Genus Level
#12 nodes
#0-30
@GenusS = ("40","41","42","43","44","45","46","47","48","49","50","30");
%Genus_hashS = map {$_ => 1} @GenusS;
$genusS = 0;
#Super Order Level
#9 nodes
#30-60
@SOS = ("31","32","33","34","35","36","37","38","39");
%SO_hashS = map {$_ => 1} @SOS;
$sup_orderS = 0;
#Order Level
#10
#60-90
@OrderS = ("18","19","22","23","24","25","26","27","28","29");
%Order_hashS = map {$_ => 1} @OrderS; 
$orderS = 0;
#Family Level
#7
#90-120
@FamilyS = ("14","15","16","17","4","20","21");
%Family_hashS = map {$_ => 1} @FamilyS;
$familyS = 0;
#Angio
#12
#120-150
@AngioS = ("1","2","3","5","6","7","8","9","10","11","12","13");
%Angio_hashS = map {$_ => 1} @AngioS;
$angioS = 0;
$totalS = 0;
open(new, "hold.txt")||die "No concordant";
while($file = <new>){
	
	chomp $file;
	$hit = ($file =~ m/concord.node.(.*)/)[0];
	if(exists $Angio_hashS{$hit}){
		$angioS += 1;
		$totalS++;
	}
	if(exists $SO_hashS{$hit}){
		$sup_orderS += 1;
		$totalS++;
	}
	if(exists $Order_hashS{$hit}){
		$orderS += 1;
		$totalS++;
	}
	if(exists $Family_hashS{$hit}){
		$familyS += 1;
		$totalS++;
	}
	if(exists $Genus_hashS{$hit}){
		$genusS += 1;
		$totalS++;
	}
}
$not_supS = $analyzable - $totalS;
#print Dumper(\@Angio);
$angio_notS = 0;
$fam_notS = 0;
$sup_notS = 0;
$order_notS = 0;
$genus_notS = 0;

foreach $keys (keys %cant_hash){

	if(exists $Angio_hashS{$keys}){
		$angio_notS++;
	}
	if(exists $Family_hashS{$keys}){
	
		$fam_notS++;
	}
	if(exists $SO_hashS{$keys}){
		$sup_notS++;
	}
	if(exists $Order_hashS{$keys}){
		$order_notS++;
	}
	if(exists $Genus_hashS{$keys}){
		$genus_notS++;
	}
}

#print "$not_supS\n";
$AngioAvailS = ($#AngioS + 1) - $angio_notS;
$AngioNSS = $AngioAvailS - $angioS;
$FamAvailS = ($#FamilyS + 1) - $fam_notS;
$FamNSS = $FamAvailS - $familyS;
$OrderAvailS = ($#OrderS + 1) - $order_notS;
$OrderNSS = $OrderAvailS - $orderS;
$SupAvailS = ($#SOS + 1) - $sup_notS;
$SupNSS = $SupAvailS - $sup_orderS;
$GenusAvailS = ($#GenusS + 1) - $genus_notS;
$GenusNSS = $GenusAvailS - $genusS;

system("pxrmt -t temp/$tree\.tre\.rr -n OG_Ginkgo_biloba,OG_Podocarpus_lambertii > temp.tre");
system("pxlstr -t temp.tre > Tree");
system("rm temp.tre");
open(another,"Tree")||die "file\n";
while($tree_line = <another>){
	
	chomp $tree_line;
	if($tree_line =~ /rttipvar/){
		$var = ($tree_line =~ m/.*?: (.*)/)[0];
	}elsif($tree_line =~ /treelength/){
		$len = ($tree_line =~ m/treelength: (.*)/)[0];
	}
		
}
	
system("rm temp/$tree\.tre\.rr");
print StatsOut "$tree\t$tot_tax\t$analyzable\t$total\t$not_sup\t$angio\t$AngioNS\t$family\t$FamNS\t$order\t$OrderNS\t$sup_order\t$SupNS\t$genus\t$GenusNS\t$totalS\t$not_supS\t$angioS\t$AngioNSS\t$familyS\t$FamNSS\t$orderS\t$OrderNSS\t$sup_orderS\t$SupNSS\t$genusS\t$GenusNSS\t$len\t$var\n";

#print "$analyzable\t$cant_count\t$total\t$angio\t$sup_order\t$order\t$family\t$genus\n";
system("rm hold.txt out.*");



