-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Giu 25, 2015 alle 18:54
-- Versione del server: 5.6.17
-- PHP Version: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `cantina`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `comprende`
--

CREATE TABLE IF NOT EXISTS `comprende` (
  `productcode` int(11) NOT NULL,
  `idordine` int(11) NOT NULL,
  `qta` int(11) NOT NULL,
  PRIMARY KEY (`productcode`,`idordine`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dump dei dati per la tabella `comprende`
--

INSERT INTO `comprende` (`productcode`, `idordine`, `qta`) VALUES
(1, 65, 1),
(3, 68, 20),
(3, 71, 1),
(4, 67, 11),
(4, 68, 1),
(5, 66, 11),
(5, 67, 1),
(5, 69, 1),
(6, 68, 8),
(7, 71, 1),
(8, 69, 1),
(9, 66, 2),
(9, 73, 1),
(9, 74, 1),
(10, 72, 1),
(10, 73, 1),
(10, 74, 1),
(11, 70, 1);

-- --------------------------------------------------------

--
-- Struttura della tabella `coupon`
--

CREATE TABLE IF NOT EXISTS `coupon` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `importo` double NOT NULL,
  `data_inizio` date NOT NULL,
  `data_fine` date NOT NULL,
  `usato` tinyint(1) DEFAULT '0',
  `cduser` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `iutente_fk_idx` (`cduser`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Dump dei dati per la tabella `coupon`
--

INSERT INTO `coupon` (`id`, `importo`, `data_inizio`, `data_fine`, `usato`, `cduser`) VALUES
(2, 50, '2014-06-13', '2017-06-19', 0, 'jeaneclaude'),
(3, 32, '2014-06-14', '2017-06-24', 0, 'darth'),
(5, 25, '2014-06-17', '2017-06-22', 0, 'jeaneclaude'),
(6, 1000, '2015-04-29', '2015-05-29', 0, 't');

-- --------------------------------------------------------

--
-- Struttura della tabella `details`
--

CREATE TABLE IF NOT EXISTS `details` (
  `productcode` int(11) NOT NULL,
  `lingua` varchar(45) NOT NULL,
  `dettagli` varchar(5000) NOT NULL,
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  FULLTEXT KEY `lingua` (`lingua`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dump dei dati per la tabella `details`
--

INSERT INTO `details` (`productcode`, `lingua`, `dettagli`, `id`) VALUES
(1, 'ita', 'Il Pinot è un vitigno molto conosciuto e diffuso. In modo particolare in Francia, dove è la base dei più noti champagne. Anche in Italia è molto diffuso, in modo particolare nelle regioni note per i loro bianchi anche lavorati a spumante: Oltrepo pavese, Trentino, Alto Adige, Franciacorta. Le d.o.c. italiane, nelle varietà bianco, grigio e nero, sono 40. Inoltre il vitigno si sta diffondendo in molte regioni per vini classificati “da tavola”.La temperatura di servizio non deve superare i 12°, meglio se inferiore. È adatto per aperitivo e si accompagna bene con i piatti delicati in genere: risotti alle verdure, creme di verdura. Buono anche con antipasti magri, ad esempio di pesce, pesce lesso o con salse molto leggere.', 0),
(2, 'ita', 'Il Cerasuolo è un vino tipico dell''Abruzzo, ottenuto da uve Montepulciano vinificate in bianco, vale a dire senza il contatto delle bucce dell''uva con il mosto, durante la macerazione. Il nome indica anche taluni vini del Lazio e della Sicilia, come il Cerasuolo di Vittoria in provincia di Ragusa.', 1),
(3, 'ita', 'Il Montefalco rosso è un vino DOC la cui produzione è consentita nell''intero territorio comunale di Montefalco, e in parte dei comuni di Bevagna, Giano dell''Umbria, Gualdo Cattaneo e Castel Ritaldi, nella provincia di Perugia.\nGli uvaggi da cui è composto sono: Sangiovese (dal 60 al 70%), Sagrantino (dal 10 al 15%), altre uve indigene fino a un massimo del 30% (tipicamente Merlot, o altri vitigni a bacca rossa autorizzati per la provincia di Perugia)', 2),
(4, 'ita', 'Il Valpolicella è un vino che nasce da una miscela di uve di vitigni diversi, la più importante è la Corvina presente in misura dal 45 al 95%, in dialetto locale è chiamata anche Cruina o semplicemente Corvina. Essenziali sono anche le uve Rondinella, dal 5 al 30%, mentre non lo sono più quelle di Molinara che è uscita dal disciplinare ma resta comunque tra quelle permesse.', 3),
(5, 'ita', 'Malvasia è un termine con il quale vengono indicati numerosi vitigni, per cui è anche appropriato parlare di Malvasie. Alcuni di questi si differenziano notevolmente tra loro per morfologia delle piante, colore, sapore e composizione biochimica del frutto, precocità di maturazione, produttività ed attitudine alla vinificazione.', 4),
(6, 'ita', 'l Sangiovese (insieme alla Barbera) è uno dei vitigni italiani più diffusi (le aree coltivate coprono l''11% della superficie viticola nazionale); viene coltivato dalla Romagna fino alla Campania ed è tradizionalmente il vitigno più diffuso in Toscana. Entra negli uvaggi di centinaia di vini, tra i quali alcuni dei più prestigiosi vini italiani: Carmignano, Rosso Piceno Superiore, Chianti e Chianti Classico, Brunello di Montalcino, Vino Nobile di Montepulciano, Montefalco rosso, Sangiovese di Romagna, Morellino di Scansano e molti altri meno conosciuti ma altrettanto validi.', 5),
(7, 'ita', 'La zona di origine delle uve atte a produrre i vini a denominazione di origine controllata e garantita «Barolo», la cui prima delimitazione risale al 31 agosto 1933, comprende i territori dei comuni di Barolo, Castiglione Falletto e Serralunga d''Alba e parte dei territori dei comuni di La Morra, Monforte d''Alba, Roddi, Verduno, Cherasco, Diano d''Alba, Novello e Grinzane Cavour in provincia di Cuneo.\n', 6),
(8, 'ita', 'Appena versato ci si accorge del colore leggermente più scuro di come te lo aspetteresti, infatti il granato è un po’ più opaco. Naso piuttosto intrigante, leggermente caldo. In bocca si sente la gioventù ma l’uso dei legni piccoli, pur evidente, non ne stravolge il profilo sensoriale, anzi la bocca evidenzia una buona freschezza.', 7),
(9, 'ita', 'L’azienda è un baglio nel cuore del Belice, i vigneti si trovano sulle colline delle Conche dell’Oro, a 300 metri slm. Mirella Tamburello, titolare dell’azienda, è autrice del rilancio di questo vitigno semi-dimenticato. Il suo perricone è affinato in botti di rovere per 12 mesi e presenta un colore rubino cupo, profondo, tendente al granato. Naso inquieto ma di carattere, si apre lentamente nel bicchiere svelando note di frutta rossa matura, erbe aromatiche, timo, rabarbaro, carruba, radice di liquirizia su un fondo di suadente balsamicità. In bocca ha corpo e struttura ma è ancora molto giovane, con un tannino incisivo che necessita di essere domato e un’acidità ben evidente. Nel retro-olfatto tornano note di rabarbaro e di cioccolata amara.', 8),
(10, 'ita', 'Esame visivo: Rosso granato intenso.\nEsame olfattivo: Gran bell''olfatto con chiare note di viola e frutta rossa, ciliegia, mora, insieme ad una aggiunta di spezie.\nEsame gustativo: Secco, caldo, pieno, di buona acidità, un frutto non ancora in confettura, ma intenso e di lunga persistenza. La qualità è eccellente, il finale è lungo.\nStato evolutivo: Pronto.\nConclusioni: Un vino che esprimerà il meglio di se tra cinque anni.', 9),
(11, 'ita', 'Macabeo, chiamato anche Viura o Macabeu è una varietà bianca di uva da vino. L''uva è usato soprattutto per produrre vini bianchi leggermente acidi e giovani per lo più adatte al consumo precoce o fusione con altre varietà, sia rossi che bianchi. Spesso è il vitigno principale della Rioja bianco ed a volte è mescolato in piccole quantità con Tempranillo e Garnacha rosso.', 10),
(12, 'ita', 'Il Negroamaro (o Negramaro) è un vitigno a bacca nera coltivato quasi esclusivamente in Puglia, in modo particolare nel Salento. L''origine del nome non è altro che la ripetizione della parola nero in due lingue: niger in latino e mavros in greco antico (da cui il dialettale maru). È uno dei principali vitigni dell''Italia Meridionale.\nÈ un''uva estremamente versatile, molto utilizzata anche per la vinificazione in rosato. In commercio è possibile reperire sia prodotti vinificati in purezza che blend. Molto noto è il Salice Salentino DOC che per disciplinare è ottenuto attraverso un blend di uve Negroamaro 85% e Malvasia Nera 15%, la quale affievolisce le caratteristiche note amarognole tipiche del Negroamaro.', 11),
(1, 'eng', 'Grapes: 100 % Falanghina\nCONTAINS SULPHITES - ALC.13 % VOL & # 65279 ;\nSoil type: medium tending to ? Clayey\nAltitude s.l.m. : 250\nSensory analysis:\nWhite Wine from pale straw yellow color , fruity aroma and tangy flavor .\nServing suggestions :\nExcellent as an aperitif and as wonderful fellow starters and fish dishes ', 12),
(2, 'eng', 'The Cerasuolo is a typical wine of Abruzzo , made from Montepulciano grapes vinified in white , that is, without contact of the grape skins with the must during the maceration . The name also indicates certain wines of Lazio and Sicily as the Cerasuolo di Vittoria in the province of Ragusa .', 13),
(3, 'eng', 'Montefalco is a red DOC wine whose production is allowed in the entire municipality of Montefalco , and in the municipalities of Bevagna , Giano of Umbria , Gualdo Cattaneo and Castel Ritaldi , in the province of Perugia .\nThe grapes from which it is made are : Sangiovese ( 60-70 % ) , Sagrantino ( 10-15 % ) , other indigenous grapes to a maximum of 30 % ( typical Merlot , or other red grapes authorized by the province Perugia )', 14),
(4, 'eng', 'Valpolicella is a wine made from a blend of grapes from different vines , the most important is the Corvina in this measure from 45 to 95 % , in the local dialect is also called Cruina or simply Corvina . Essential is also the grapes Rondinella , 5-30 % , while they are no longer those of Molinara that is output by the disciplinary but remains among those allowed .', 15),
(5, 'eng', 'Malvasia is a term with which outlines a number of varieties , it is also appropriate to speak of Malvasia . Some of these differ greatly from each other to plant morphology , color , flavor and biochemical composition of the fruit , early maturing , productivity and aptitude for wine-making .', 16),
(6, 'eng', 'the Sangiovese ( along with Barbera ) is one of the most popular Italian varieties ( cultivated areas cover 11% of the total vineyard area ) ; It is grown from Romagna to Campania and is traditionally the most popular grape in Tuscany . Log in blends of hundreds of wines , including some of the most prestigious Italian wines : Carmignano , Rosso Piceno Superiore , Chianti and Chianti Classico , Brunello di Montalcino , Vino Nobile di Montepulciano , Montefalco red , Sangiovese di Romagna , Morellino di Scansano and many other lesser known but equally valid .', 17),
(7, 'eng', 'The area of origin of the grapes used to produce wines with a designation of origin and guaranteed " Barolo " , whose first boundary dates back to August 31 , 1933, includes the municipalities of Barolo , Castiglione Falletto and Serralunga d''Alba and part of municipalities of La Morra , Monforte d''Alba , Roddi , Verduno , Cherasco , Diano d''Alba , Novello and Grinzane Cavour in the province of Cuneo .', 18),
(8, 'eng', 'Just poured you notice the slightly darker color of it like you ''d expect , in fact, the garnet is a bit '' more opaque . Nose rather intriguing , slightly warm . In the mouth you feel the youth but the use of small woods , while obvious , is not it distorts the sensory profile , even the mouth reveals a good freshness .', 19),
(9, 'eng', 'The company is a rural farm in the heart of the Belice , the vineyards are located in the hills of the Golden Conche , 300 meters above sea level . Mirella Tamburello , owner of the company , is the author of the revival of this vine semi - forgotten . His perricone is aged in oak barrels for 12 months and has a dark ruby ​​color , deep garnet . Nose but restless character , opens slowly in the glass revealing notes of ripe red fruit , herbs , thyme , rhubarb , carob , licorice root against a background of soothing balsamic . The mouth has body and structure but is still very young , with an incisive tannins that need to be tamed and acidity evident . In retro- olfaction back notes of rhubarb and dark chocolate .', 20),
(10, 'eng', 'Appearance: Deep garnet red .\nNose: Great bell''olfatto with clear notes of violet and red fruit , cherry , blackberry , along with an addition of spices .\nTaste: Dry, warm, full , with good acidity , a fruit still not jam, but intense and persistent . The quality is excellent , the finish is long .\nEvolutionary state : Ready .\nConclusion : A wine that expresses its best in five years .', 21),
(11, 'eng', 'Macabeo, also called Viura or Macabeu is a white variety of wine grape. The grape is mostly used to make mildly acidic and young white wines mostly suitable for early consumption or blending with other varieties, both red and white. It is often the main grape of white Rioja and is sometimes blended in small amounts with Tempranillo and red Garnacha.', 22),
(12, 'eng', 'Negroamaro ( or Negramaro ) is a red grape variety grown almost exclusively in Puglia , particularly in Salento . The origin of the name is nothing more than the repetition of the word black in two languages ​​: niger in Latin and ancient greek mavros in (hence the dialect maru ) . It is one of the main grape of southern Italy .\nIt is an extremely versatile grape , also used extensively for vinification in rosé . In the market you can find both products that blend vinified in purity . Very well known is the Salice Salentino DOC that governing is achieved through a blend of 85 % Negroamaro and Malvasia Nera 15 % , which weakens the features bitter notes typical of Negroamaro .', 23),
(2, 'fra', 'Le Cerasuolo est un vin typique des Abruzzes , à partir de raisins Montepulciano vinifiés en blanc , qui est, sans contact avec des peaux de raisin avec le moût pendant la macération. Le nom indique également certains vins du Latium et de la Sicile que le Cerasuolo di Vittoria dans la province de Raguse .', 25),
(3, 'fra', 'Montefalco est une DOC vin rouge dont la production est autorisée dans toute la municipalité de Montefalco , et dans les municipalités de Bevagna , Giano de l''Ombrie , Gualdo Cattaneo et Castel Ritaldi , dans la province de Pérouse .\nLes raisins dont il est fait sont : Sangiovese (60-70% ) , Sagrantino ( 10-15% ) , les autres cépages indigènes à un maximum de 30 % ( de Merlot typique , ou d''autres raisins rouges autorisés par la province Pérouse )', 26),
(4, 'fra', 'Valpolicella est un vin fait à partir d''un mélange de raisins provenant de différentes vignes , le plus important est la Corvina dans cette mesure 45 à 95 % , dans le dialecte local est aussi appelé Cruina ou simplement Corvina . Essential est également raisins Rondinella , 5-30 % , plus alors qu''ils sont ceux de Molinara qui est sortie par le disciplinaire, mais reste parmi ceux autorisés .', 27),
(5, 'fra', 'Malvasia est un terme qui décrit un certain nombre de variétés , il est également approprié de parler de Malvasia . Certaines d''entre elles diffèrent grandement les uns des autres pour planter la morphologie, la couleur, la saveur et la composition biochimique des fruits , maturation précoce , la productivité et l''aptitude pour la vinification .', 28),
(6, 'fra', 'Sangiovese (avec Barbera ) est l''une des variétés les plus populaires italiens ( zones cultivées couvrent 11 % de la superficie totale du vignoble ) ; est passée de Romagne à la Campanie et est traditionnellement le cépage le plus populaire en Toscane . Connectez mélanges de centaines de vins , y compris certains des plus prestigieux vins italiens : Carmignano , Rosso Piceno Superiore , Chianti et Chianti Classico , Brunello di Montalcino , Vino Nobile di Montepulciano , Montefalco rouges , Sangiovese di Romagna , Morellino di Scansano et de nombreux d''autres moins connus mais tout aussi valables .', 29),
(7, 'fra', 'La région d''origine des raisins utilisés pour produire des vins bénéficiant d''une appellation d''origine et garantis " Barolo " , dont la première frontière remonte au 31 Août 1933, comprend les municipalités de Barolo , Castiglione Falletto et Serralunga d''Alba et une partie de municipalités de La Morra , Monforte d'' Alba , Roddi , Verduno , Cherasco , Diano d'' Alba , Novello et Grinzane Cavour dans la province de Cuneo .', 30),
(8, 'fra', 'Juste versé vous remarquez que la couleur légèrement plus foncée d''elle comme on pouvait s''y attendre , en fait, le grenat est un peu plus opaque. Nez plutôt intrigante , un peu chaud . Dans la bouche, vous sentez les jeunes , mais l''utilisation de petits bois , tout évident, non il déforme le profil sensoriel , même la bouche révèle une bonne fraîcheur .', 31),
(9, 'fra', 'La société est une ferme rurale dans le cœur de la Belice , les vignobles sont situés dans les collines de la Conche d''Or , à 300 mètres au dessus du niveau de la mer. Mirella Tamburello , propriétaire de la société , est l''auteur de la renaissance de cette vigne semi- oubli. Son Perricone est vieilli en fûts de chêne pendant 12 mois et a une couleur rubis foncé , grenat profond . Nez mais le caractère agité, ouvre lentement dans le verre révélant des notes de fruits rouges mûrs , les herbes , le thym , la rhubarbe , de caroube , la racine de réglisse sur un fond balsamique apaisante . La bouche a du corps et de la structure , mais est encore très jeune , avec une tanins incisifs qui doivent être apprivoisés et l''acidité évidente. Dans les notes dos rétro -olfaction de rhubarbe et de chocolat noir .', 32),
(10, 'fra', 'Apparence : Rouge grenat intense .\nNez: Grande bell''olfatto avec des notes claires de violette et de fruits rouges , de cerise , de mûre , avec un ajout d''épices .\nGoût: sec , chaud , plein , avec une bonne acidité , un fruit pas encore de la confiture , mais intense et persistante . La qualité est excellente , la finale est longue .\nÉtat évolutif : Prêt .\nConclusion : Un vin qui exprime son meilleur dans cinq ans.', 33),
(11, 'fra', 'Macabeo, aussi appelé Viura ou Macabeu est une variété blanche de vin de raisin. Le raisin est le plus souvent utilisé pour faire des vins blancs légèrement acides et les jeunes surtout adaptés à la consommation précoce ou de mélange avec d''autres variétés, rouges et blancs. Il est souvent le principal cépage blanc Rioja et est parfois mélangé en petites quantités avec Tempranillo et Garnacha rouge.', 34),
(12, 'fra', 'Negroamaro (ou Negramaro ) est un cépage rouge cultivé presque exclusivement dans les Pouilles , en particulier dans le Salento . L''origine du nom est rien de plus que la répétition du mot noir en deux langues : Niger en latin et en grec dans mavros anciens (d''où le maru dialecte ) . Il est l''un des principal cépage du sud de l''Italie .\nIl est un cépage très polyvalent , aussi largement utilisé pour la vinification en rosé . Sur le marché , vous pouvez trouver les deux produits qui se marient vinifié en pureté. Très bien connu est le DOC Salice Salentino que gouverner est obtenu grâce à un mélange de 85 % Negroamaro et Malvasia Nera 15 % , ce qui affaiblit les caractéristiques typiques des notes amères Negroamaro .', 35),
(1, 'spa', 'Uvas: 100 % Falanghina\r\nCONTIENE SULFITOS - ALC.13 % VOL & # 65279 ;\r\nTipo de suelo : el cuidado de medio a arcilloso ?\r\nS.l.m. Altitud : 250\r\nAnálisis sensorial :\r\nVino Blanco de color pálido amarillo pajizo , aroma afrutado y sabor picante .\r\nSugerencias:\r\nExcelente como aperitivo y como maravilloso compañeros de entrantes y platos de pescado .', 36),
(2, 'spa', 'El Cerasuolo es un vino típico de los Abruzos, elaborado con uvas Montepulciano vinificado en blanco, es decir , sin contacto de los hollejos con el mosto durante la maceración. El nombre también indica determinados vinos de Lazio y Sicilia como Cerasuolo di Vittoria en la provincia de Ragusa.', 37),
(3, 'spa', 'Montefalco es un vino DOC rojo cuya producción está permitida en todo el municipio de Montefalco, y en los municipios de Bevagna, Giano de la Umbría , Gualdo Cattaneo y Castel Ritaldi , en la provincia de Perugia.\nLas uvas de la que se hace son: Sangiovese (60-70 % ) , Sagrantino ( 10-15 % ) , otras uvas autóctonas a un máximo del 30 % ( Merlot típica u otras uvas tintas autorizadas por la provincia Perugia )', 38),
(4, 'spa', 'Valpolicella es un vino elaborado a partir de una mezcla de uvas de diferentes viñedos , la más importante es la Corvina en esta medida de 45 a 95 % , en el dialecto local se llama también Cruina o simplemente Corvina . Esencial también es la uva Rondinella , 5-30 %, mientras que ya no son los de Molinara que se emite por la disciplinarias pero sigue siendo uno de los permitidos .', 39),
(5, 'spa', 'Malvasia es un término con el que se esbozan una serie de variedades , también es apropiado hablar de Malvasia . Algunas de ellas son muy diferentes unos de otros para plantar morfología, color, sabor y composición bioquímica de la fruta, de maduración temprana , la productividad y la aptitud para la vinificación .', 40),
(6, 'spa', 'el Sangiovese (junto con Barbera ) es una de las variedades italianas más populares ( áreas cultivadas cubren el 11% de la superficie total del viñedo ) ; está pasado de Romaña a Campania y es tradicionalmente la uva más popular en la Toscana. Entre las mezclas de cientos de vinos , incluyendo algunos de los vinos italianos más prestigiosos : Carmignano , Rosso Piceno Superiore , Chianti y Chianti Classico , Brunello di Montalcino , Vino Nobile di Montepulciano , Montefalco rojos , Sangiovese di Romagna , Morellino di Scansano y muchos otros menos conocidos pero igualmente válido.', 41),
(7, 'spa', 'La zona de origen de las uvas utilizadas para producir vinos con denominación de origen y garantizados " Barolo " , cuyo primer límite se remonta al 31 de agosto de 1933, incluye los municipios de Barolo, Castiglione Falletto y Serralunga d'' Alba y parte de municipios de La Morra, Monforte d'' Alba , Roddi , Verduno , Cherasco, Diano d'' Alba , Novello y Grinzane Cavour en la provincia de Cuneo .', 42),
(8, 'spa', 'Simplemente vierte observa el color ligeramente más oscuro en ello como era de esperar, de hecho, el granate es un poco más opaco. Nariz bastante intrigante , un poco caliente . En boca se siente la juventud, pero el uso de pequeños bosques , mientras que obvio, no se distorsiona el perfil sensorial , incluso la boca revela una buena frescura.', 43),
(9, 'spa', 'La compañía es una granja rural en el corazón de la Belice , los viñedos se encuentran en las colinas de la Conche de Oro , a 300 metros sobre el nivel del mar. Mirella Tamburello , dueño de la empresa , es el autor de la reactivación de esta semi - olvidado vid. Su Perricone es envejecido en barricas de roble durante 12 meses y tiene un color rubí oscuro , granate profundo. Nariz pero el carácter inquieto, se abre lentamente en el vaso que revela notas de fruta roja madura , hierbas , el tomillo , el ruibarbo , el algarrobo , la raíz de regaliz sobre un fondo balsámico de calmante. La boca tiene cuerpo y estructura, pero es aún muy joven , con un tanino incisivas que deben ser domesticados y acidez evidente. En las notas de respaldo retro olfacción de ruibarbo y chocolate negro.', 44),
(10, 'spa', 'Apariencia : granate de color rojo oscuro .\nNariz: Gran bell''olfatto con claras notas de violetas y frutos rojos , cereza , mora , junto con una adición de especias.\nSabor: seco, cálido, lleno , con buena acidez, una fruta aún no mermelada, pero intenso y persistente. La calidad es excelente, el final es largo .\nEstado evolutivo: Listo .\nConclusión : Un vino que expresa su máxima expresión en cinco años.', 45),
(11, 'spa', 'Macabeo, también llamada Viura o Macabeo es una variedad blanca de uva de vinificación. La uva se utiliza sobre todo para hacer vinos blancos ligeramente ácidas y jóvenes en su mayoría aptas para el consumo temprano o mezclado con otras variedades, tanto rojo y blanco. A menudo es la uva principal de blanco Rioja ya veces se mezcla en pequeñas cantidades con Tempranillo y Garnacha roja.', 46),
(12, 'spa', 'Negroamaro (o Negramaro ) es una variedad de uva roja crecido casi exclusivamente en Puglia , en particular en Salento . El origen del nombre no es más que la repetición de la palabra negro en dos idiomas : niger en los antiguos griegos en mavros (de ahí el maru dialecto ) y América . Es una de la uva principal del sur de Italia.\nEs una uva muy versátil , también se utiliza ampliamente para la vinificación en rosado. En el mercado se pueden encontrar tanto productos que combinan vinificado en pureza. Muy conocido es el DOC Salice Salentino que gobernar se logra a través de una mezcla de 85 % Negroamaro y Malvasia Nera 15 %, lo que debilita las características notas amargas típicos de Negroamaro .', 47),
(13, 'ita', 'Uvaggio: 100% Falanghina\nCONTIENE SOLFITI - ALC. 13,50% VOL.&#65279;\nTerreno: medio impasto tendente all?argilloso - Altitudine s.l.m. : 250mt\nAllevamento: tendone campano sul vigneto vecchio e filare sul vigneto giovane\nTipo di vinificazione : tradizionale a temperatura controllata\nQuanto affinameto in bottiglia: 4 mesi minimo\nAnalisi sensoriale: Vino dal colore rosa ciliegia dal profumo fresco fruttato di piccoli frutti rossi e fragola e dal sapore gradevolmente sapido e leggermente vellutato.\n', 48),
(13, 'eng', 'Grapes: 100 % Falanghina\nCONTAINS SULPHITES - ALC.13 % VOL & # 65279 ;\nSoil type: medium tending to ? Clayey\nAltitude s.l.m. : 250\nSensory analysis:\nWhite Wine from pale straw yellow color , fruity aroma and tangy flavor .\nServing suggestions :\nExcellent as an aperitif and as wonderful fellow starters and fish dishes ', 49),
(13, 'fra', 'Cépages: 100 % Falanghina\nContient des sulfites - ALC.13 % VOL & # 65279 ;\nType de sol : moyen tendant à argileux ?\nAltitude s.l.m. : 250\nAnalyse sensorielle :\nVin Blanc de pâle couleur jaune paille , arôme fruité et la saveur acidulée .\nSuggestion d''accompagnement:\nExcellent en apéritif et aussi merveilleux compagnons entrées et de plats de poisson .', 50),
(13, 'spa', 'Uvas: 100 % Falanghina\nCONTIENE SULFITOS - ALC.13 % VOL & # 65279 ;\nTipo de suelo : el cuidado de medio a arcilloso ?\nS.l.m. Altitud : 250\nAnálisis sensorial :\nVino Blanco de color pálido amarillo pajizo , aroma afrutado y sabor picante .\nSugerencias:\nExcelente como aperitivo y como maravilloso compañeros de entrantes y platos de pescado .', 51),
(14, 'de', 'asd', 52),
(0, 'special', 'No detail in your language for this product. Sorry.', 53);

-- --------------------------------------------------------

--
-- Struttura della tabella `ordine`
--

CREATE TABLE IF NOT EXISTS `ordine` (
  `idordine` int(11) NOT NULL AUTO_INCREMENT,
  `data_ordine` date NOT NULL,
  `via` varchar(45) NOT NULL,
  `citta` varchar(55) NOT NULL,
  `cap` varchar(10) NOT NULL,
  `data_consegna` date NOT NULL,
  `stato` varchar(60) NOT NULL DEFAULT 'in ritiro',
  `cduser` varchar(50) NOT NULL,
  PRIMARY KEY (`idordine`),
  KEY `ordiniutente_fk_idx` (`cduser`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=75 ;

--
-- Dump dei dati per la tabella `ordine`
--

INSERT INTO `ordine` (`idordine`, `data_ordine`, `via`, `citta`, `cap`, `data_consegna`, `stato`, `cduser`) VALUES
(24, '2014-06-14', 'dfs', 'fdfdfd', '44020', '2014-06-17', 'consegnato', 't'),
(43, '2015-04-17', 'asdsdsd', 'Ferrara', '44121', '2015-04-20', 'in ritiro', 't'),
(44, '2015-04-17', 'asdsdsd', 'Ferrara', '44121', '2015-04-20', 'in ritiro', 't'),
(45, '2015-04-17', 'via bellaria 17', 'Ferrara', '44121', '2015-04-20', 'in ritiro', 't'),
(46, '2015-04-18', 'asasasasas', 'Rovigo', '55123', '2015-04-21', 'in ritiro', 't'),
(47, '2015-04-18', 'sdsd', 'Rovigo', 'sdsd', '2015-04-21', 'in ritiro', 't'),
(48, '2015-04-18', 'garibaldi 12', 'Rome', '121212', '2015-04-21', 'in ritiro', 't'),
(49, '2015-04-18', 'via bellaria 17', 'Ferrara', '44121', '2015-04-21', 'in ritiro', 'darth'),
(50, '2015-04-18', 'asdsdsd', 'Ferrara', '44121', '2015-04-21', 'in ritiro', 't'),
(51, '2015-04-18', 'asdsdsd', 'Ferrara', '44121', '2015-04-21', 'in ritiro', 't'),
(52, '2015-04-18', 'garibaldi 12', 'Rovigo', '121212', '2015-04-21', 'in ritiro', 'darth'),
(53, '2015-04-18', 'assas', 'Roma', 'sasass', '2015-04-21', 'in ritiro', 't'),
(54, '2015-04-18', 'via bellaria 17', 'Roma', '44356', '2015-04-21', 'in ritiro', 't'),
(55, '2015-04-18', 'asdsdsd', 'Ferrara', '55123', '2015-04-21', 'in ritiro', 't'),
(56, '2015-04-18', 'via bellaria 17', 'Bergamo', '123213', '2015-04-21', 'in ritiro', 't'),
(57, '2015-04-18', 'garibaldi 12', 'Rovigo', '44121', '2015-04-21', 'in ritiro', 't'),
(59, '2015-04-19', 'via bellaria 17', 'Cento', '44321', '2015-04-22', 'Consegnato al corriere', 'darth'),
(65, '2015-05-01', 'ferrara', 'Ferrara', '44100', '2015-05-04', 'in ritiro', 'albe'),
(74, '2015-06-04', 'rt', 'rtr', 'rt', '2015-06-07', 'in ritiro', 'jeaneclaude');

-- --------------------------------------------------------

--
-- Struttura della tabella `pagamento`
--

CREATE TABLE IF NOT EXISTS `pagamento` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data` date NOT NULL,
  `stato` varchar(45) NOT NULL,
  `importo_pagamento` double NOT NULL,
  `idordine` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pagordine_fk_idx` (`idordine`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=33 ;

--
-- Dump dei dati per la tabella `pagamento`
--

INSERT INTO `pagamento` (`id`, `data`, `stato`, `importo_pagamento`, `idordine`) VALUES
(24, '2014-06-27', 'confermato', 569.99, 54),
(26, '2015-04-18', 'confermato', 99, 57),
(27, '2015-04-19', 'confermato', 19, 58),
(28, '2015-04-19', 'confermato', 232, 59),
(29, '2015-05-01', 'confermato', 12.5, 65),
(30, '2015-05-01', 'confermato', 346, 66),
(31, '2015-05-01', 'confermato', 358, 67),
(32, '2015-05-03', 'confermato', 402, 68);

-- --------------------------------------------------------

--
-- Struttura della tabella `prodotto`
--

CREATE TABLE IF NOT EXISTS `prodotto` (
  `productcode` int(11) NOT NULL DEFAULT '0',
  `nome_p` varchar(100) DEFAULT NULL,
  `regione` varchar(100) DEFAULT NULL,
  `type_p` varchar(100) DEFAULT NULL,
  `quantita` varchar(200) DEFAULT NULL,
  `prezzo` varchar(200) DEFAULT NULL,
  `path` varchar(100) DEFAULT NULL,
  `cduser` varchar(50) NOT NULL,
  PRIMARY KEY (`productcode`),
  KEY `acontatti_fk_cd_user` (`nome_p`),
  FULLTEXT KEY `CDUSER` (`cduser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dump dei dati per la tabella `prodotto`
--

INSERT INTO `prodotto` (`productcode`, `nome_p`, `regione`, `type_p`, `quantita`, `prezzo`, `path`, `cduser`) VALUES
(1, 'Pinot Bianco d.o.c', 'Trentino Alto Adige', 'W', '50', '12.5', 'pinot.jpg', 'mariorossi'),
(2, 'PRIMAMADRE CERASUOLO  DOC SUPERIORE', 'Vini La Quercia Società Agricola LA.DI Snc.', 'O', '125', '7.0', 'primamadre.jpg', 'mariorossi'),
(3, 'MONTEFALCO ROSSO D.O.C. 2009', 'Società Agricola Perticaia Srl', 'R', '35', '14.0', 'montefalco.jpg', 'mariorossi'),
(4, 'VALPOLICELLA DOC CLASSICO 2013', 'Azienda Agricola Scriani', 'R', '85', '34.0', 'valpolicella.jpg', 'mariorossi'),
(5, 'Malvasia', 'DOC Collio Goriziano o Collio Malvasia', 'W', '55', '34.0', 'malvasia.jpg', 'mariorossi'),
(6, 'Sangiovese', 'DOC Montepulciano d`Abruzzo Rosso', 'R', '231', '11.0', 'sangiovese.jpg', 'vittorioneri'),
(7, 'Recioto della Valpolicella ', 'DOC Recioto della Valpolicella Valpantena', 'R', '198', '22.0', 'recioto.jpg', 'vittorioneri'),
(8, 'Barolo Docg ', 'Piemonte', 'R', '143', '22.0', 'barolo.jpg', 'vittorioneri'),
(9, 'Pietragavina 2007 \r\nMonreale Doc ', 'Sicilia', 'R', '21', '11.0', 'pietravigna.jpg', 'vittorioneri'),
(10, 'Barolo Ornato 1999-Pio Cesare', 'Lombardia', 'R', '21', '12.0', 'barolo1.jpg', 'vittorioneri'),
(11, 'Macabeo', 'La Mancha', 'W', '259', '7.7', 'macabeo.jpg', 'rositabanderas'),
(12, 'Negroamaro', 'Puglia', 'R', '120', '12.5', 'negroamaro.jpg', 'rositabanderas'),
(13, 'Falanghina', 'Campania', 'B', '123', '22', 'falanghina.jpg', 'rositabanderas'),
(14, 'asd', 'asd', 'B', '123', '123.0', 'asd', 'mariorossi');

-- --------------------------------------------------------

--
-- Struttura della tabella `utenti`
--

CREATE TABLE IF NOT EXISTS `utenti` (
  `cd_contact` int(11) NOT NULL DEFAULT '0',
  `cduser` varchar(100) DEFAULT NULL,
  `pwd` varchar(100) NOT NULL,
  `nome` varchar(100) DEFAULT NULL,
  `cognome` varchar(100) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `via` varchar(200) DEFAULT NULL,
  `citta` varchar(100) DEFAULT NULL,
  `tel` varchar(50) DEFAULT NULL,
  `usertype` varchar(1) DEFAULT NULL,
  `lingua` varchar(30) NOT NULL,
  PRIMARY KEY (`cd_contact`),
  KEY `acontatti_fk_cd_user` (`cduser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dump dei dati per la tabella `utenti`
--

INSERT INTO `utenti` (`cd_contact`, `cduser`, `pwd`, `nome`, `cognome`, `email`, `via`, `citta`, `tel`, `usertype`, `lingua`) VALUES
(0, 'admin', 'admin', 'admin', 'admin', 'admin.vino@mail.com', 'Vitigno, 11', 'Ferrara\r\n', '3353535354', NULL, 'ita'),
(1, 'mariorossi', 'mario', 'Mario', 'Rossi', 'mario.rossi@mail.com', 'G.Garibaldi, 14', 'Milano', '3467895058', 'V', 'ita'),
(2, 'jeaneclaude', 'jeane', 'Jeane', 'Claude', 'jeane.claude@mail.com', 'Marie Eures, 80', 'Paris', '3476985110', 'C', 'fra'),
(4, 'rositabanderas', 'rosita', 'Rosita', 'Banderas', 'rosita.banderas@email.com', 'Ignacio Gaspard, 183', 'Madrid', '3456789119', 'V', 'spa'),
(5, 'vittorioneri', 'vittorio', 'Vittorio', 'Neri', 'vittorio.neri@mail.com', 'XX Settembre, 15', 'Napoli', '3677812362', 'V', 'ita'),
(6, 'johnsmith', 'john', 'John', 'Smith', 'john.smith@mail.com', 'Undersea, 51', 'London', '23423235235', 'C', 'eng'),
(7, 'georgelucas', 'george', 'George', 'Lucas', 'george.lucas@mail.com', 'Garibaldi 13', 'Los Angeles', '23232132323233', 'C', 'eng'),
(8, 'manny', 'manuel', 'Manuel', 'Calavera', 'manny.calavera@mail.com', 'Gambones, 1698', 'Pamplona', '33864269952', 'C', 'spa'),
(9, 'moniqueodille', 'monique', 'Monique', 'Odille', 'monique.odille@mail.com', 'Ferrara, 32', 'Bordeaux', '3332194411', 'C', 'fra');

-- --------------------------------------------------------

--
-- Struttura della tabella `visualizza`
--

CREATE TABLE IF NOT EXISTS `visualizza` (
  `cduser` varchar(20) NOT NULL,
  `productcode` int(11) NOT NULL,
  PRIMARY KEY (`productcode`,`cduser`),
  KEY `utente_fk_idx` (`cduser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dump dei dati per la tabella `visualizza`
--

INSERT INTO `visualizza` (`cduser`, `productcode`) VALUES
('a', 2),
('a', 4),
('a', 6),
('a', 8),
('a', 9),
('a', 10),
('admin', 6),
('admin', 11),
('albe', 1),
('darth', 6),
('Emperor', 2),
('Emperor', 4),
('Emperor', 7),
('Emperor', 9),
('Emperor', 10),
('jeaneclaude', 1),
('jeaneclaude', 2),
('jeaneclaude', 3),
('jeaneclaude', 4),
('jeaneclaude', 5),
('jeaneclaude', 6),
('jeaneclaude', 7),
('jeaneclaude', 8),
('jeaneclaude', 9),
('jeaneclaude', 10),
('jeaneclaude', 11),
('jeaneclaude', 14),
('t', 1),
('t', 2),
('t', 3),
('t', 4),
('t', 5),
('t', 6),
('t', 7),
('t', 8),
('t', 9),
('t', 10);

-- --------------------------------------------------------

--
-- Struttura della tabella `wishlist`
--

CREATE TABLE IF NOT EXISTS `wishlist` (
  `cduser` varchar(50) NOT NULL,
  `productcode` int(11) NOT NULL,
  PRIMARY KEY (`productcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dump dei dati per la tabella `wishlist`
--

INSERT INTO `wishlist` (`cduser`, `productcode`) VALUES
('darth', 1),
('t', 2),
('t', 6),
('darth', 7),
('t', 8);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
