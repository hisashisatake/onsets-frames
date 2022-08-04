# Dual-Objective Piano Transcription

## 元ネタ

https://qiita.com/burugaria7/items/4005724c5d1b5228327e

この内容をDockerfileに落とし込んでみました。

- 参照

    https://magenta.tensorflow.org/onsets-frames

## 使い方

Dockerfileを配置したディレクトリに移動して、以下のコマンドでビルドします。

    $ docker build -t magenta ./


ビルドが終わったら、docker runで実行できます。

    $ docker run -v [任意のフルパス]:/opt/of magenta [任意の.wavファイル名]

.wavファイルをホストとコンテナで共有するために、VOLUMEを使います。VOLUMEにバインドされるコンテナ側のディレクトリは"/opt/of"固定です。

任意のフルパスはVOLUMEの実体となり、その中に.wavファイルを配置して解析させます。任意の.wavファイル名を省略した場合、デフォルトでmagenta.wavを参照します。

- 例) 任意のフルパスを~/docker/magenta/ofにする
    
    あらかじめ、~/docker/magenta/of/wavを作成しておき、magenta.wavを配置して、以下のコマンドを実行します。

        $ docker run -v ~/docker/magenta/of:/opt/of magenta

    必要に応じて、/opt/of/train上にモデルデータがダウンロードされ、解析を開始、~/docker/magenta/wav上にmagenta.wav.midiが生成されます。

- 例) 任意の.wavファイル名を指定する

    任意のフルパスは~/docker/magenta/ofとして、任意の.wavファイル名を指定します。あらかじめ、~/docker/magenta/of/wav上にexample.wavファイルを配置します。

          $ docker run -v ~/docker/magenta/wav:/opt/wav magenta example.wav

    解析が開始され、~/docker/magenta/wav上にexample.wav.midiが生成されます。
