# frozen_string_literal: true

shared_examples_for 'mounttab resource' do
  it { is_expected.to have_mounttab_resource_count(1) }

  it do
    is_expected.to contain_mounttab('/mnt').only_with('name' => '/mnt',
                                                      'ensure'    => 'present',
                                                      'device'    => '/dev/myvg/mytest',
                                                      'fstype'    => 'ext4',
                                                      'options'   => 'defaults',
                                                      'provider'  => 'augeas')
  end
end

shared_context 'mounttab' do
  it { is_expected.to have_mounttab_resource_count(0) }

  let :example_params do
    { '/mnt' => { 'device' => '/dev/myvg/mytest', 'fstype' => 'ext4', 'options' => 'defaults' } }
  end

  context 'when mounttab_hash is a Hash' do
    let(:params) { { mounttab_hash: example_params } }
    let(:facts) { {} }

    include_examples 'mounttab resource'
  end

  context 'when ::augeasproviders_mounttab_hash is a Hash' do
    let(:params) { {} }
    let(:facts) { { augeasproviders_mounttab_hash: example_params } }

    include_examples 'mounttab resource'
  end
end
